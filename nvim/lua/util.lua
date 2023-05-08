-- *****************************************************************************
--   Utilities
-- *****************************************************************************

vim.cmd([[
    fun! GetNow() abort
        " 現在時刻を取得する関数
        let l:day = printf('%d', strftime('%d'))
        let l:nday = l:day[len(l:day)-1]
        let l:daytail = 'th'
        if     l:nday == 1
            let l:daytail = 'st'
        elseif l:nday == 2
            let l:daytail = 'nd'
        elseif l:nday == 3
            let l:daytail = 'rd'
        endif
        let l:day = l:day . l:daytail . ' '
        let l:nweek = strftime('%w')
        let l:weeks = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
        let l:week = l:weeks[l:nweek] . ' '
        let l:nmonth = strftime('%m') - 1
        let l:months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
        let l:month = l:months[l:nmonth] . ' '
        let l:now = l:week . l:month . l:day
        let l:now .= strftime('%H:%M:%S %Y')
        " let l:now .= strftime('%H:%M:%S %z (%Z) %Y')
        " let l:now = strftime('%Y-%m-%d(%a) %H:%M:%S')
        return l:now
    endf
]])
