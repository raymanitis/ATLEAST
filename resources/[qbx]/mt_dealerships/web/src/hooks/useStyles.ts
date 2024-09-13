import { createStyles } from '@mantine/core'

const useStyles = createStyles((theme) => ({
    wrapper: {
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
        height: '100vh',
        position: 'fixed',
        width: '100%'
    },
    header: {
        width: '100%',
        height: 50,
        borderTopLeftRadius: theme.radius.sm,
        borderTopRightRadius: theme.radius.sm,
        borderBottom: '1px solid #373a40',
        display: 'flex',
        justifyContent: 'space-between'
    },
    categoriesPaper: {
        width: '100%',
        height: 54,
        overflow: 'hidden',
        padding: '5px',
        backgroundColor: theme.colors.dark[8]
    },
    categoriesBox: {
        width: '100%',
        height: '100%',
        display: 'flex',
        justifyContent: 'flex-start',
        alignItems: 'center',
        overflowX: 'auto',
        whiteSpace: 'nowrap',
        gap: '5px'
    },
    vehiclesMainPaper: {
        '&::-webkit-scrollbar': {
            display: 'none'
        },
        width: '100%',
        height: 590,
        padding: '5px',
        display: 'flex',
        alignItems: 'flex-start',
        flexDirection: 'row',
        flexWrap: 'wrap',
        whiteSpace: 'nowrap',
        gap: '10px',
        paddingLeft: '10px',
        paddingRight: '10px',
        marginTop: '-5px',
        overflowX: 'hidden',
        overflow: 'auto',
        scrollbarWidth: 'none',
        backgroundColor: theme.colors.dark[8]
    },
    vehiclePaper: {
        width: '250px',
        padding: '5px',
        display: 'flex',
        justifyContent: 'center',
        flexDirection: 'row',
        flexWrap: 'wrap',
        whiteSpace: 'nowrap',
        gap: '2px',
        cursor: 'pointer'
    },
    vehicleModalBtns: {
        padding: '5px',
        width: '100%',
        display: 'flex',
        justifyContent: 'center',
        flexDirection: 'row',
        flexWrap: 'wrap',
        alignItems: 'center',
        marginTop: '5px'
    },
    vehicleBadges: {
        width: '100%',
        display: 'flex',
        justifyContent: 'center',
        flexDirection: 'row',
        flexWrap: 'wrap',
        alignItems: 'center',
        gap: '5px'
    },
    modalFix: {
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        height: '100%',
        fontFamily: 'sans-serif',
        '.mantine-Modal-modal': {
            margin: 'auto',
            top: 0,
            bottom: 0,
        },
    },
    removeScroll: {
        '&::-webkit-scrollbar': {
            display: 'none'
        },
        maxHeight: 500,
        overflow: 'auto'
    }
}))

export default useStyles