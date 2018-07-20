let b:ale_linters = ['flake8']
" initial script
if getline(0, '$') == ['']
    call append(0, '#!/usr/bin/env python')
    call append(1,'# -*- coding: utf-8 -*-')
    call append(2,'"""')
    call append(3,'Created on '.GetNow())
    call append(4,'   @file  : '.expand('%:t'))
    call append(5,'   @author: Suzuki')
    call append(6,'   @brief :')
    call append(7,'"""')
endif
