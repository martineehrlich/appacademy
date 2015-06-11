def stock_picker(array)
  profit = nil
  idx = 0
    while idx < array.length
        idx2 = idx + 1
        while idx2 < array.length
            if (array[idx2] - array[idx]) > 0 && (profit == nil || array[idx2] - array[idx] > profit)
                profit = array[idx2] - array[idx]
                buy_idx = idx
                sell_idx = idx2
            end
          idx2 += 1
        end
      idx += 1
    end

return buy_idx, sell_idx

end


puts stock_picker( [ 44, 30, 24, 32, 35, 30, 40, 38 ] ) == [ 2, 6 ]
