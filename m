Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE33BC28D13
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Aug 2022 10:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiHVKto (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 Aug 2022 06:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbiHVKtn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Aug 2022 06:49:43 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BA22F659
        for <fstests@vger.kernel.org>; Mon, 22 Aug 2022 03:49:41 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220822104937euoutp02576cc1e1f6825a0485d0bdc4caf954bd~NpRwS7o_k2137121371euoutp02K
        for <fstests@vger.kernel.org>; Mon, 22 Aug 2022 10:49:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220822104937euoutp02576cc1e1f6825a0485d0bdc4caf954bd~NpRwS7o_k2137121371euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661165377;
        bh=nAyfse9e331ASDNAeWcgO1Yowva186zHFI6AljZcIMg=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=CfFTcmjFoOl33BkDoBRSYMEbzuIKrbBjiV07E9oKgL2F59WmfZ5h1J8rrktBZqlrc
         svNfpGH2uc6552oV1LR4XZ0K08jB7YQYkWkTQwtYn49mjabc/OJA4JlkmrYDD8tBMp
         MPMiJZHlCirFoG3pnIY73zj+tXzum1V6pNW1P5Kc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220822104937eucas1p2adbe9f97eb167d572b315d798253eae6~NpRv9O-Ri2656126561eucas1p2i;
        Mon, 22 Aug 2022 10:49:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7A.7D.19378.14F53036; Mon, 22
        Aug 2022 11:49:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220822104936eucas1p211261b047eb63725c241f0da4c52d91e~NpRvkTi8u2656126561eucas1p2f;
        Mon, 22 Aug 2022 10:49:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220822104936eusmtrp2b78e641a3d03dad98de60f03d213464e~NpRvjm51n0223502235eusmtrp2g;
        Mon, 22 Aug 2022 10:49:36 +0000 (GMT)
X-AuditID: cbfec7f5-a35ff70000014bb2-da-63035f41ecc1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A1.F4.07473.04F53036; Mon, 22
        Aug 2022 11:49:36 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220822104936eusmtip1463eb992fb419c21c54802f2448e596c~NpRvXWm3X0423904239eusmtip1C;
        Mon, 22 Aug 2022 10:49:36 +0000 (GMT)
Received: from [106.110.32.100] (106.110.32.100) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 22 Aug 2022 11:49:35 +0100
Message-ID: <08bba73a-4e13-63ea-3a4c-33dba359a84f@samsung.com>
Date:   Mon, 22 Aug 2022 12:49:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.11.0
Subject: Re: [RFC 1/1] btrfs/237: adapt the test to work with the new
 reclaim algorithm
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <PH0PR04MB741618CBF8C989CB7AE2E6E99B719@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.100]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTURjGO7t3916l2XEVvpi2Whl9kH3LopIWIiuCoojIPnTpZZlzya72
        pYXZSpxpmma5zBTLzLRsE21IWaM0m9NWsdTI/kiLhhNKI2uotV0L//u953mf877P4TCEuEIY
        yMRrklmtRqmWUr5kQ8uvzqXyaCJ2+dA4LXPbOglZhfsnKbPqHtGyUX2vQNaV149k+a0moaym
        u5/cSCvMhg+0wlidRSnM5z4KFe1lz2jFkHG2IvNJtmA7FeW7Po5Vxx9ltcvCY3wPvS6vopP0
        occdFRHpKHeBHvkwgFeDo/smoUe+jBhXIbg3cneiGEaQ3VIv4IshBA5LDv3PUvMlk+aF2wjs
        3/uI/1225s8UXzQhGCvqID0WEQ6HzjK3107iEGjraCf4c39oK+7z9szEe6Cmyebtmf6XB0Z0
        XiZwAPT03RB4eAY+DGcLraRnAIFLBZDlfCfUI4ah8GI4k0V70Afvh8dvd/DWRXCu0T1xjQQa
        XSUEn0AKeaUfKZ5PQW1LuzcN4EwfuFN7U8gLEdB26+qEYTo4W+sn4gfBuJnfB3Aq9He5Cd6s
        Q3DRfJ/yLAF4HeS2q3mUw5mSOTz6QZfLn1/HDy41XCHyUIhh0kMYJgU2TEpgmJSgDJHVKIBN
        4RJVLLdKwx4L5ZSJXIpGFRp7JNGI/v4j61jrj4eoyvkt1IIEDLIgYAjpDFGqfUqsWBSnPHGS
        1R6J1qaoWc6CZjGkNEAUG1+nFGOVMplNYNkkVvtPFTA+gekCVWO2vx0P9i59e81hLN+aQb95
        s/18ZW9lRmT+r+jivDmlzp60QHXBXkkUDj46ZUPEc+H7oEqXbmcwJa2+tDtIWzQWx5jqtjFY
        LUnDA8OVITtiSozl96NmP0jm7JdlzgHztBejkT+LTPcsZdbNIz1+KzdRtVR4y1z54+ac3fVg
        tS0LG898ZX+pKi5Y9VVuL0jamarOeBL59SCl/bQlQTx4XL32wOGu98IQydRB2/yO4foHgwu3
        sZFP962Uf9NJaBOZFNyIThc65l0XaRrM6YG90eYY+6KmfJdr3tbnvx8Wss9y6DUX6Lk9BtPo
        ku66sPSwqrTOH2ebd3HyBQm51VKSO6RcsZjQcso/AeLA3bYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xu7oO8czJBtdPaFr8Pnue2WLx7+8s
        Fqdb9rJb/O26x2RxY8JTRouJxzezWqy5+ZTFgd1j56y77B6bVnWyeexsvc/qcWbBEXaPz5vk
        PNoPdDMFsEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp
        2yXoZVxauIK9oEuv4tpilwbGPrUuRk4OCQETiTXP29m7GLk4hASWMkosXniPFSIhI/Hpykd2
        CFtY4s+1LjaIoo+MEr9bX7NCOLsZJfZcmA1WxStgJ3F+wW8wm0VAVeLkuTPMEHFBiZMzn7CA
        2KICkRIPlzUxgdjCQHbX5x1g25gFxCVuPZkPFhcRyJKYPPMvM8gCZoF5TBKdr65DbZvAJHH6
        +n+gOzg42AS0JBo72UFMToFYiX1XgiDmaEq0boe4gVlAXmL72znMEB8oSUyYd58Nwq6VeHV/
        N+MERtFZSM6bheSMWUhGzUIyagEjyypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAON527Ofm
        HYzzXn3UO8TIxMF4iFGCg1lJhLf6IkOyEG9KYmVValF+fFFpTmrxIUZTYBhNZJYSTc4HJpK8
        knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQamOdm5b9dFWmeYyWt9
        2Fa3ZuXX8KsTd5RKrDqrLmt/WNvF+H6J5OT8VNNLX65tv7pVf5bR/55ZVYaLsiQzrZqn7tBr
        KtiumT4hKiF86TcVodjQzxc+hUZrmHa9T9/M7p+pfeNFel+5iYzklSq+mQ9WZktYTVr+/c++
        qbf5rPl/pDh2536KLZq32dr8xl0mDdNfsetcVG/4+ry7pH752YWZH576L5Mwmp4g+/MVC3tq
        YlnuorUq+butz+o9+efZH/YnQ/G/0kq/HZ/m/3ZVrJTdlPiM7cnuX1rpOTqSqac/7Zb1vV/Q
        H8W+PljwwapLE6NUjGwmb/zKYPl8pXOGwoZyid9LbMLvdnzw8t8iJVaixFKckWioxVxUnAgA
        HI0isWwDAAA=
X-CMS-MailID: 20220822104936eucas1p211261b047eb63725c241f0da4c52d91e
X-Msg-Generator: CA
X-RootMTR: 20220819115339eucas1p1896638f0a9a3d0c71c7fcba3b754b8ad
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220819115339eucas1p1896638f0a9a3d0c71c7fcba3b754b8ad
References: <20220819115337.35681-1-p.raghav@samsung.com>
        <CGME20220819115339eucas1p1896638f0a9a3d0c71c7fcba3b754b8ad@eucas1p1.samsung.com>
        <20220819115337.35681-2-p.raghav@samsung.com>
        <PH0PR04MB741618CBF8C989CB7AE2E6E99B719@PH0PR04MB7416.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2022-08-22 11:40, Johannes Thumshirn wrote:
> On 19.08.22 13:53, Pankaj Raghav wrote:
>> Since 3687fcb0752a ("btrfs: zoned: make auto-reclaim less aggressive")
>> commit, reclaim algorithm has been changed to trigger auto-reclaim once
>> the fs used size is more than certain threshold. This change breaks this
>> test.
>>
>> The test has been adapted so that the new auto-reclaim algorithm can be
>> tested along with relocation.
> 
> S-o-b missing.
Oops. I hope it can be added before committing.
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

> 
> Thanks for doing this!
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
Thanks for testing it Johannes.

I did encounter an issue when I was trying out this test in a larger zoned
device. I have explained the issue in my cover letter. I don't know if it
is an issue with QEMU. As I don't have a physical PO2 device with me, did
you see any of the issue I mentioned in the cover letter? If not, it might
be an issue with the QEMU ZNS implementation.

>> ---
>>  tests/btrfs/237 | 80 +++++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 57 insertions(+), 23 deletions(-)
>>
>> diff --git a/tests/btrfs/237 b/tests/btrfs/237
>> index f96031d5..18945e78 100755
>> --- a/tests/btrfs/237
>> +++ b/tests/btrfs/237
>> @@ -54,46 +54,80 @@ if [[ "$uuid" == "" ]]; then
>>  	exit 1
>>  fi
>>  
>> +fssize=$($BTRFS_UTIL_PROG fi usage -b $SCRATCH_MNT |grep "Device size" |\
>> +	grep -Eo "[0-9]+")
>> +
>> +allocated_fssize=$($BTRFS_UTIL_PROG fi usage -b $SCRATCH_MNT |grep "Device allocated" |\
>> +	grep -Eo "[0-9]+")
>> +
>> +
>>  start_data_bg_phy=$(get_data_bg_physical)
>>  start_data_bg_phy=$((start_data_bg_phy >> 9))
>>  
>> -size=$($BLKZONE_PROG report -o $start_data_bg_phy -l 1 $SCRATCH_DEV |\
>> +zone_cap=$($BLKZONE_PROG report -o $start_data_bg_phy -l 1 $SCRATCH_DEV |\
>>  	_filter_blkzone_report |\
>>  	grep -Po "cap 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
>> -size=$((size << 9))
>> +zone_cap=$((zone_cap << 9))
>>  
>> -reclaim_threshold=75
>> -echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
>> -fill_percent=$((reclaim_threshold + 2))
>> -rest_percent=$((90 - fill_percent)) # make sure we're not creating a new BG
>> -fill_size=$((size * fill_percent / 100))
>> -rest=$((size * rest_percent / 100))
>> +fs_reclaim_threshold=60
>> +bg_reclaim_threshold=75
>> +echo $fs_reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
>> +echo $bg_reclaim_threshold > /sys/fs/btrfs/"$uuid"/allocation/data/bg_reclaim_threshold
>>  
>> -# step 1, fill FS over $fillsize
>> -$XFS_IO_PROG -fc "pwrite 0 $fill_size" $SCRATCH_MNT/$seq.test1 >> $seqres.full
>> -$XFS_IO_PROG -fc "pwrite 0 $rest" $SCRATCH_MNT/$seq.test2 >> $seqres.full
>> +fs_fill_percent=$((fs_reclaim_threshold + 2))
>> +fill_size=$((fssize * fs_fill_percent / 100))
>> +
>> +# Remove the allocated size from the $fill_size
>> +fill_size=$((fill_size - allocated_fssize))
>> +
>> +bg_fill_percent=$((bg_reclaim_threshold + 2))
>> +zone_fill_size=$((zone_cap * bg_fill_percent / 100))
>> +
>> +# $fill_size might not cover the last zone block group with threshold
>> +# for reclaim. Add the remaining bytes so that it can also be reclaimed
>> +last_zone_offset=$((fill_size % zone_cap))
>> +
>> +if [ $last_zone_offset -lt $zone_fill_size ]; then
>> +	fill_size=$((fill_size + zone_fill_size - last_zone_offset))
>> +fi
>> +
>> +# This small file will be used to verify the relocation
>> +relocate_file_size=$((zone_cap * 2 / 100))
>> +
>> +# step 1, fill FS over $relocated_file_size and $fill_size
>> +$XFS_IO_PROG -fc "pwrite 0 $relocate_file_size" $SCRATCH_MNT/$seq.test1 >> $seqres.full
>>  $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
>>  
>> -zones_before=$($BLKZONE_PROG report $SCRATCH_DEV | grep -v -e em -e nw | wc -l)
>> -echo "Before reclaim: $zones_before zones open" >> $seqres.full
>>  old_data_zone=$(get_data_bg)
>>  old_data_zone=$((old_data_zone >> 9))
>>  printf "Old data zone 0x%x\n" $old_data_zone >> $seqres.full
>>  
>> -# step 2, delete the 1st $fill_size sized file to trigger reclaim
>> -rm $SCRATCH_MNT/$seq.test1
>> +$XFS_IO_PROG -fc "pwrite 0 $fill_size" $SCRATCH_MNT/$seq.test2 >> $seqres.full
>>  $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
>> -sleep 2 # 1 transaction commit for 'rm' and 1 for balance
>> +
>> +open_zones_before_reclaim=$($BLKZONE_PROG report --offset $start_data_bg_phy $SCRATCH_DEV |\
>> +	grep -v -e em -e nw | wc -l)
>> +
>> +# sanity check
>> +if [ $open_zones_before_reclaim -eq 0 ]; then
>> +	echo "Error writing to the device"
>> +fi
>> +
>> +echo "Before reclaim: $open_zones_before_reclaim zones open" >> $seqres.full
>> +
>> +# step 2, delete the $fill_size sized file to trigger reclaim
>> +rm $SCRATCH_MNT/$seq.test2
>> +$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
>> +sleep 5 # sleep for transaction commit for 'rm' and for balance
>>  
>>  # check that we don't have more zones open than before
>> -zones_after=$($BLKZONE_PROG report $SCRATCH_DEV | grep -v -e em -e nw | wc -l)
>> -echo "After reclaim: $zones_after zones open" >> $seqres.full
>> +open_zones_after_reclaim=$($BLKZONE_PROG report --offset $start_data_bg_phy $SCRATCH_DEV |\
>> +	grep -v -e em -e nw | wc -l)
>> +echo "After reclaim: $open_zones_after_reclaim zones open" >> $seqres.full
>>  
>> -# Check that old data zone was reset
>> -old_wptr=$($BLKZONE_PROG report -o $old_data_zone -c 1 $SCRATCH_DEV |\
>> -	grep -Eo "wptr 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
>> -if [ "$old_wptr" != "0x000000" ]; then
>> -	_fail "Old wptr still at $old_wptr"
>> +# Check that data was really relocated to a different zone
>> +if [ $open_zones_after_reclaim != 1 ]; then
>> +	echo "Error relocating the data"
>>  fi
>>  
>>  new_data_zone=$(get_data_bg)
> 
