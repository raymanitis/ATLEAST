import React, { useState, useEffect } from "react"
import { Paper, Box, Input, Group, Button, CloseButton, ScrollArea, Image, Text, Badge } from '@mantine/core'
import { modals } from '@mantine/modals'
import { useNuiEvent } from "../hooks/useNuiEvent"
import { fetchNui } from "../utils/fetchNui"
import { getVehicleImage, formatPrice, sortVehiclesByLowestPrice } from "../utils/misc"
import useStyles from '../hooks/useStyles'
import { MdOutlineCancel, MdOutlineCheck, MdOutlineDirectionsCar } from "react-icons/md"
import { TbFileDollar } from "react-icons/tb"
import { FaCreditCard, FaSearch } from "react-icons/fa"

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
    allowBuyCatalogue?: any
}

const Catalogue: React.FC = () => {
    const { classes } = useStyles()
    const [categoriesData, setCategoriesData] = useState<Category[]>([])
    const [vehiclesData, setVehiclesData] = useState<Vehicle[]>([])
    const [searchTerm, setSearchTerm] = useState<string>('')
    const [dealershipData, setDealershipData] = useState<Dealership | null>(null)
    const [playerMoney, setPlayerMoney] = useState<number>(0)
    const [vehicleImages, setVehicleImages] = useState<any>({})
    const [locales, setLocales] = useState<any>({})
    const [canChangeVehicle, setCanChangeVehicle] = useState<boolean>(false)
    const [vehicleId, setVehicleId] = useState<string>('')

    useNuiEvent<any>('catalogue', (data) => {
        if (data.locales) setLocales(data.locales)
        if (data.categories && Array.isArray(data.categories)) setCategoriesData(data.categories)
        if (data.vehicles && Array.isArray(data.vehicles)) setVehiclesData(sortVehiclesByLowestPrice(data.vehicles))
        if (data.dealership) setDealershipData(data.dealership)
        if (data.playerMoney) setPlayerMoney(data.playerMoney)
        if (data.canChangeVehicle) setCanChangeVehicle(data.canChangeVehicle)
        if (data.vehicleId) setVehicleId(data.vehicleId)
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
                    <Input placeholder={locales.ui_search} w={500} style={{ margin: '5px', }} value={searchTerm} icon={<FaSearch/>} onChange={(event) => setSearchTerm(event.currentTarget.value)} />
                    <Group>
                        <Badge variant="light" size="lg" color="green" leftSection={<FaCreditCard/>}>{formatPrice(playerMoney, locales.ui_currency || 'USD')}</Badge>
                        <CloseButton size='lg' style={{ margin: 5 }} onClick={() => fetchNui('hideFrame', { name: 'setVisibleCatalogue' })} />
                    </Group>
                </Paper>

                {/* Categories */}
                <Paper className={classes.categoriesPaper}>
                    <ScrollArea h={"100%"} scrollbarSize={6} scrollHideDelay={0}>
                        <Box className={classes.categoriesBox}>
                            <Button variant="light" style={{ margin: '5px' }} color="yellow" size="xs" onClick={() => setSearchTerm('')}>{locales.ui_all}</Button>
                            {dealershipData?.job && dealershipData?.useStock && (<Button variant="light" style={{ margin: '5px' }} color="yellow" size="xs" onClick={() => setSearchTerm('stock')}>{locales.ui_stocked}</Button>)}

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
                                    size: 'sm',
                                    className: classes.modalFix,
                                    children: (
                                        <div className={classes.removeScroll}>
                                            <Image height={220} fit='contain' alt='No Image' src={vehicleImages[model] || `https://gta-images.s3.fr-par.scw.cloud/vehicle/${model}.webp`} />
                                            <Text fw={700} size='xl'>{brand} {name}</Text>
                                            <Text fw={600} size='md'>{locales.ui_price}: <Badge variant='light' size='md' color='green'>{formatPrice(price, locales.ui_currency || 'USD')}</Badge></Text>
                                            {dealershipData?.job && dealershipData?.useStock && (<Text fw={600} size='md'>{locales.ui_stock}: <Badge variant='light' size='md' color='cyan'>{stock}</Badge></Text>)}
                                            <Text fw={600} size='md'>{locales.ui_category}: <Badge variant='light' size='md'>{category}</Badge></Text>
                                            {vehicleClass && (<Text fw={600} size='md'>{locales.ui_class}: <Badge variant='light' size='md' color='yellow'>{vehicleClass}</Badge></Text>)}
                                            {weight && (<Text fw={600} size='md'>{locales.ui_weight}: <Badge variant='light' size='md' color='grape'>{weight}kg</Badge></Text>)}
                                            {seats && (<Text fw={600} size='md'>{locales.ui_seats}: <Badge variant='light' size='md' color='violet'>{seats}</Badge></Text>)}
                                            <Group className={classes.vehicleModalBtns}>
                                                {(!dealershipData?.job || (dealershipData?.job && dealershipData?.allowBuyCatalogue)) && (<Button variant="light" color="green" size="xs" leftIcon={<TbFileDollar/>} disabled={(dealershipData?.job && dealershipData?.useStock && (stock || 0) <= 0)}
                                                    onClick={() => {
                                                        modals.closeAll();
                                                        modals.open({
                                                            title: locales.ui_confirm_buy_vehicle_title,
                                                            centered: true,
                                                            size: 'xs',
                                                            className: classes.modalFix,
                                                            children: (
                                                                <div className={classes.removeScroll}>
                                                                    <Text>{locales.ui_confirm_buy_vehicle_message}</Text>
                                                                    <Group className={classes.vehicleModalBtns}>
                                                                        <Button variant="light" color="red" size="sm" leftIcon={<MdOutlineCancel/>} onClick={() => { modals.closeAll() }}>{locales.ui_cancel}</Button>
                                                                        <Button variant="light" color="green" size="sm" leftIcon={<MdOutlineCheck/>} onClick={() => { modals.closeAll(); fetchNui('buyVehicle', { model: model, dealership: dealershipData }) }}>{locales.ui_confirm}</Button>
                                                                    </Group>
                                                                </div>
                                                            )
                                                        })
                                                }}>{locales.ui_buy}</Button>)}
                                                {canChangeVehicle && (<Button variant="light" color="gray" size="xs" onClick={() => { modals.closeAll(); fetchNui('changeShowroomVehicle', { vehicleId: vehicleId, newVehicle: model, dealership: dealershipData }) }} leftIcon={<MdOutlineDirectionsCar/>}>{locales.ui_change_vehicle}</Button>)}
                                                <Button variant="light" color="cyan" size="xs" onClick={() => { modals.closeAll(); fetchNui('testDrive', { model: model, dealership: dealershipData }) }} leftIcon={<MdOutlineDirectionsCar/>}>{locales.ui_test_drive}</Button>
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
                                {dealershipData?.job && dealershipData?.useStock && (<Badge size='sm' variant='light' color='cyan'>{stock}</Badge>)}
                                {vehicleClass && (<Badge size='sm' variant='light' color='yellow'>{vehicleClass}</Badge>)}
                            </Group>
                        </Paper>
                    ))}
                </Paper>
            </Paper>
        </div>
    )
}

export default Catalogue