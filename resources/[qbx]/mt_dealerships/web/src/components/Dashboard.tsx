import React, { useState, useEffect } from "react"
import { Paper, Box, Input, Group, Button, CloseButton, ScrollArea, Image, Text, Badge, Select } from '@mantine/core'
import { modals } from '@mantine/modals'
import { useNuiEvent } from "../hooks/useNuiEvent"
import { fetchNui } from "../utils/fetchNui"
import useStyles from '../hooks/useStyles'
import { getVehicleImage, formatPrice, sortVehiclesByLowestPrice } from "../utils/misc"
import { BsBank } from "react-icons/bs"
import { CiExport, CiImport } from "react-icons/ci"
import { MdOutlineCancel, MdOutlineCheck } from "react-icons/md"
import { TbFileDollar } from "react-icons/tb"
import { IoAddCircleOutline } from "react-icons/io5"
import { FaSearch, FaRegUser } from "react-icons/fa"

interface Category {
    id: string
    label: string
}

interface Vehicle {
    model: string
    name: string
    brand: string
    price: number
    category: string
    shop: string
    stock?: number
    class?: string
    seats?: string
    weight?: number
}

interface Dealership {
    label: string
    job: any
    currency: string
    logo: string
    useStock?: boolean
    needsMission?: boolean
    testDriveRoutingBucket: boolean
    testDriveTime: number
    testDriveSpawn: any
    truckSpawn?: any
    buySpawn: any
    truck?: string
    trailer?: string
}

interface Sells {
    buyerName: string
    price: number
    vehicle: string
    sellerName: string
    plate: string
    date: string
}

interface Importations {
    workerName: string
    price: number
    vehicle: string
    date: string
}

const Dashboard: React.FC = () => {
    const { classes } = useStyles()
    const [categoriesData, setCategoriesData] = useState<Category[]>([])
    const [vehiclesData, setVehiclesData] = useState<Vehicle[]>([])
    const [searchTerm, setSearchTerm] = useState<string>('')
    const [inImportation, setImportation] = useState<string>('')  
    const [dealershipData, setDealershipData] = useState<Dealership | null>(null)
    const [dealershipMoney, setDealershipMoney] = useState<number>(0)
    const [vehicleImages, setVehicleImages] = useState<any>({})
    const [locales, setLocales] = useState<any>({})
    const [sells, setSells] = useState<Sells[]>([])
    const [importations, setImportations] = useState<Importations[]>([])

    useNuiEvent<any>('dashboard', (data) => {
        if (data.locales) setLocales(data.locales)
        if (data.categories && Array.isArray(data.categories)) setCategoriesData(data.categories)
        if (data.vehicles && Array.isArray(data.vehicles)) setVehiclesData(sortVehiclesByLowestPrice(data.vehicles))
        if (data.dealership) setDealershipData(data.dealership)
        if (data.dealershipMoney) setDealershipMoney(data.dealershipMoney)
        if (data.sells) setSells(data.sells)
        if (data.importations) setImportations(data.importations)
    })

    useEffect(() => {
        const fetchVehicleImages = async () => {
            const images: { [key: string]: string } = {}
            for (const vehicle of vehiclesData) {
                images[vehicle.model] = await getVehicleImage(vehicle.model)
            }
            setVehicleImages(images)
        }
        fetchVehicleImages()
    }, [vehiclesData])

    useNuiEvent<any>('importationState', (data) => {
        setImportation(data.state)
    })

    const filteredVehicles = vehiclesData.filter((vehicle) => {
        const { model, name, brand, category, stock } = vehicle
        const searchValue = searchTerm.toLowerCase()
        if (searchValue == 'stock') return ((stock || 0) > 0)
        return (model.toLowerCase().includes(searchValue) || name.toLowerCase().includes(searchValue) || brand.toLowerCase().includes(searchValue) || category.toLowerCase().includes(searchValue))
    })

    return (
        <div className={classes.wrapper}>
            <Paper withBorder shadow="lg" radius='sm' w={1312} h={690}>
                {/* Header */}
                <Paper className={classes.header}>
                    <Image style={{ height: 50, width: 90, padding: 5 }} fit='contain' src={dealershipData?.logo} />
                    <Input placeholder={locales.ui_search} w={500} style={{ margin: '5px' }} value={searchTerm} icon={<FaSearch/>} onChange={(event) => setSearchTerm(event.currentTarget.value)}/>
                    <Group style={{ margin: '5px' }}>
                        <Badge variant="light" size="lg" color="green" leftSection={<BsBank/>}>{formatPrice(dealershipMoney, locales.ui_currency || 'USD')}</Badge>
                        <Button variant="light" color="teal" size="sm" leftIcon={<CiExport/>} onClick={() => {
                            modals.open({
                                title: locales.ui_dealership_sells_title,
                                centered: true,
                                size: 'xs',
                                radius: 'sm',
                                className: classes.modalFix,
                                children: (
                                    <div className={classes.removeScroll}>
                                        {sells.length > 0 && sells.map(({ buyerName, price, vehicle, sellerName, plate, date }) => (
                                            <Paper withBorder radius='sm' style={{ padding: 5, marginBottom: 5 }}>
                                                <Text fw={600} size='md'>{locales.ui_date}: <Badge variant='light' size='md'>{date || 'N/A'}</Badge></Text>
                                                <Text fw={600} size='md'>{locales.ui_employee}: <Badge variant='light' size='md'>{sellerName || 'N/A'}</Badge></Text>
                                                <Text fw={600} size='md'>{locales.ui_customer}: <Badge variant='light' size='md'>{buyerName || 'N/A'}</Badge></Text>
                                                <Text fw={600} size='md'>{locales.ui_plate}: <Badge variant='light' size='md'>{plate || 'N/A'}</Badge></Text>
                                                <Text fw={600} size='md'>{locales.ui_model}: <Badge variant='light' size='md'>{vehicle || 'N/A'}</Badge></Text>
                                                <Text fw={600} size='md'>{locales.ui_price}: <Badge variant='light' size='md' color='green'>{formatPrice(price, locales.ui_currency || 'USD') || 'N/A'}</Badge></Text>
                                            </Paper>
                                        ))}
                                    </div>
                                )
                            })
                        }}>{locales.ui_sells}</Button>
                        {dealershipData?.useStock && (<Button variant="light" color="teal" size="sm" leftIcon={<CiImport/>} onClick={() => {
                            modals.open({
                                title: locales.ui_dealership_importations_title,
                                centered: true,
                                size: 'xs',
                                className: classes.modalFix,
                                children: (
                                    <div className={classes.removeScroll}>
                                        {importations.length > 0 && importations.map(({ workerName, price, vehicle, date }) => (
                                            <Paper withBorder radius='sm' style={{ padding: 5, marginBottom: 5 }}>
                                                <Text fw={600} size='md'>{locales.ui_date}: <Badge variant='light' size='md'>{date || 'N/A'}</Badge></Text>
                                                <Text fw={600} size='md'>{locales.ui_employee}: <Badge variant='light' size='md'>{workerName || 'N/A'}</Badge></Text>
                                                <Text fw={600} size='md'>{locales.ui_model}: <Badge variant='light' size='md'>{vehicle || 'N/A'}</Badge></Text>
                                                <Text fw={600} size='md'>{locales.ui_price}: <Badge variant='light' size='md' color='red'>{formatPrice(price, locales.ui_currency || 'USD') || 'N/A'}</Badge></Text>
                                            </Paper>
                                        ))}
                                    </div>
                                )
                            })
                        }}>{locales.ui_importations}</Button>)}
                        <CloseButton size="lg" onClick={() => fetchNui('hideFrame', { name: 'setVisibleDashboard' })} />
                    </Group>
                </Paper>

                {/* Categories */}
                <Paper className={classes.categoriesPaper}>
                    <ScrollArea h={"100%"} scrollbarSize={6} scrollHideDelay={0}>
                        <Box className={classes.categoriesBox}>
                            <Button variant="light" style={{ margin: '5px' }} color="yellow" size="xs" onClick={() => setSearchTerm('')}>{locales.ui_all}</Button>
                            {dealershipData?.useStock && (<Button variant="light" style={{ margin: '5px' }} color="yellow" size="xs" onClick={() => setSearchTerm('stock')}>{locales.ui_stocked}</Button>)}

                            {categoriesData.length > 0 && categoriesData.map(({ id, label }) => (
                                <Button key={id} variant="light" style={{ margin: '5px', cursor: 'pointer' }} size="xs" onClick={() => setSearchTerm(id)}>{label}</Button>
                            ))}
                        </Box>
                    </ScrollArea>
                </Paper>

                {/* Vehicles list */}
                <Paper className={classes.vehiclesMainPaper}>
                    {filteredVehicles.length > 0 && filteredVehicles.map(({ model, name, brand, price, category, class: vehicleClass, seats, weight, stock }) => (
                        <Paper className={classes.vehiclePaper} radius='sm' withBorder shadow="xs"
                            onClick={() => {
                                modals.open({
                                    title: locales.ui_vehicle_info_title,
                                    centered: true,
                                    size: 'xs',
                                    className: classes.modalFix,
                                    children: (
                                        <div className={classes.removeScroll}>
                                            <Image height={220} fit='contain' alt='No Image' src={vehicleImages[model] || `https://gta-images.s3.fr-par.scw.cloud/vehicle/${model}.webp`} />
                                            <Text fw={700} size='xl'>{brand} {name}</Text>
                                            <Text fw={600} size='md'>{locales.ui_price}: <Badge variant='light' size='md' color='green'>{formatPrice(price, locales.ui_currency || 'USD')}</Badge></Text>
                                            {dealershipData?.useStock && (<Text fw={600} size='md'>{locales.ui_stock}: <Badge variant='light' size='md' color='cyan'>{stock}</Badge></Text>)}
                                            <Text fw={600} size='md'>{locales.ui_category}: <Badge variant='light' size='md'>{category}</Badge></Text>
                                            {vehicleClass && (<Text fw={600} size='md'>{locales.ui_class}: <Badge variant='light' size='md' color='yellow'>{vehicleClass}</Badge></Text>)}
                                            {weight && (<Text fw={600} size='md'>{locales.ui_weight}: <Badge variant='light' size='md' color='grape'>{weight}kg</Badge></Text>)}
                                            {seats && (<Text fw={600} size='md'>{locales.ui_seats}: <Badge variant='light' size='md' color='violet'>{seats}</Badge></Text>)}
                                            <Group className={classes.vehicleModalBtns}>
                                                <Button variant="light" color="green" size="sm" leftIcon={<TbFileDollar/>} disabled={(dealershipData?.useStock && (stock || 0) <= 0)}
                                                    onClick={() => { modals.closeAll(); fetchNui('sellVehicle', { model: model, dealership: dealershipData }) }}>{locales.ui_sell}</Button>
                                                {dealershipData?.useStock && inImportation && (<Button variant="light" color="red" size="sm" leftIcon={<MdOutlineCancel/>} onClick={() => { modals.closeAll(); fetchNui('cancelStock') }}>{locales.ui_cancel_stock}</Button>)}
                                                {dealershipData?.useStock && !inImportation && (<Button variant="light" color="cyan" size="sm" leftIcon={<IoAddCircleOutline/>}
                                                    onClick={() => {
                                                        modals.closeAll();
                                                        modals.open({
                                                            title: locales.ui_confirm_importation_title,
                                                            centered: true,
                                                            size: 'xs',
                                                            className: classes.modalFix,
                                                            children: (
                                                                <div className={classes.removeScroll}>
                                                                    <Text>{locales.ui_confirm_importation_message}</Text>
                                                                    <Group className={classes.vehicleModalBtns}>
                                                                        <Button variant="light" color="red" size="sm" leftIcon={<MdOutlineCancel/>} onClick={() => { modals.closeAll() }}>{locales.ui_cancel}</Button>
                                                                        <Button variant="light" color="green" size="sm" leftIcon={<MdOutlineCheck/>} onClick={() => { modals.closeAll(); fetchNui('stockVehicle', { model: model, dealership: dealershipData}) }}>{locales.ui_confirm}</Button>
                                                                    </Group>
                                                                </div>
                                                            )
                                                        })
                                                }}>{locales.ui_add_stock}</Button>)}
                                            </Group>
                                        </div>
                                    )
                                })
                            }
                        }>
                            <Image height={120} style={{ padding: 5 }} radius='sm' fit='contain' alt='No Image' src={vehicleImages[model] || `https://gta-images.s3.fr-par.scw.cloud/vehicle/${model}.webp`} />
                            <Text size='sm' fw={700}>{brand} {name}</Text>
                            <Group className={classes.vehicleBadges}>
                                <Badge size='sm' variant='light' color='green'>{formatPrice(price, locales.ui_currency || 'USD')}</Badge>
                                {dealershipData?.useStock && (<Badge size='sm' variant='light' color='cyan'>{stock}</Badge>)}
                                {vehicleClass && (<Badge size='sm' variant='light' color='yellow'>{vehicleClass}</Badge>)}
                            </Group>
                        </Paper>
                    ))}
                </Paper>
            </Paper>
        </div>
    )
}

export default Dashboard