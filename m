Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1DCC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 16 Mar 2022 23:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiCPXVo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 16 Mar 2022 19:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242387AbiCPXVm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 16 Mar 2022 19:21:42 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61E3657F
        for <fstests@vger.kernel.org>; Wed, 16 Mar 2022 16:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647472823; x=1679008823;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fCTUQ9/J0khBA4n/3stpxcUezEMtxLUgwH0K6Icknv8=;
  b=cBQCpUFZST70rR/TxjIWr0lwA1exfMUwrQ18iLh3w+WzzPLKdgBuGvSD
   qSi5nnJaKPe3Uxw33nU2dfeKiChBPy95f54cSs97JQ5gVcoTPvNwQV9nu
   iISMnZd6ibBuTgcVSBk8VbbzvJZ9yTvzKBrU/NQO0F2ubE0/xMCGuo9aU
   wp62wYEFwyGUsrf/17mPr1Eu39q8qXG0RK7TR9zk1p3aT9a67/fe8XeuS
   M+gYvtL1/sFYrCwqOZQE0ZFfUGdKrNis849sdatvYiOVqUqmUWO0xil7S
   kjplNEkRlx9bDidYTlFrhqY0/9nVHMpPDM6KiuSVIDiprTGLgiNk0A3Lr
   g==;
X-IronPort-AV: E=Sophos;i="5.90,187,1643644800"; 
   d="scan'208";a="194466531"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2022 07:20:22 +0800
IronPort-SDR: b6mCRn5+KYam/xK0VCptbvAJb3SDXrdDk6hmkARfZADnxSW41e3qRJvnQ8Mjzf+pDrbOI0SUJF
 Cs0Wl3bOvXaBf62Tw93Znb+we5AlCw2vWfSfKyUkXOMEY7nJJ1JXBgktErVKMSM+F09wyAjXt3
 3mQwr3ROdJj0ebQwuYhrO0mTKIr3wig/SDpum7kQDs3UbXWg6Lk19FIiO2CNQ8NbisAOVbKfnL
 pw5loBrrtIlNlaOEDUlLqUvGfQKBWCHAkwR6e44A2heuFPJwTmxCnnNBwy0mkaTZpkjxIgg3+X
 CO0sddW85pImjvH4Tx3CezgA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 15:51:28 -0700
IronPort-SDR: MD/fIlTHnLkQPCR07STciCs6ejXNJZYCF/jSR9WE7cULLV+1oUHCCuaQ8RmQMMASNaWOPh5PI6
 mi915sQ1XbUvkysRz2WgIS1mCubyc4fQhCSfIuEjTDcO6gB9f6j9yf/WlFNcmnI2xv8r9v/wEj
 mkz5DhkCb6gYFxenocL6l7YXsulpqaml1o/uukgXkK5VDofUaallWWNo8X30eCM2vzm1AiqjXW
 okUkB1gBzrifbmWc/deshJSsGzN9MLFIxYPGqF6Q15CfIBPNLyDtYZpoT14iN+XA9tQWSDJRb8
 EUI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 16:20:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KJmTf4xNXz1Rwrw
        for <fstests@vger.kernel.org>; Wed, 16 Mar 2022 16:20:22 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647472821; x=1650064822; bh=fCTUQ9/J0khBA4n/3stpxcUezEMtxLUgwH0
        K6Icknv8=; b=EtRGBiIOt0wp5PtYqNEropi+Ar0fl7GtWUYb7xA+pSSfXZBFIpc
        Z0wsVN8n51T4CNLq+TB4F+ULHDqCrlHga1NrmL2tUwZL+8b5+FtkL+36KgR5Uy00
        EsOGRtcmZnWzMo7BAMHjYYd/eRgDscg2fdjNMCWcEMp4ThEcNcT4JTbnDpYxksgd
        5Vjur7omRgO2/UhY2lqVStLFV4ZX9c1GwYMb5eIrlp82hXLkOXWrFWHYrZCzECIF
        raE4JwCeZ56ljruNU6q1ZhNaW6u3lodyfIDCZvbjr08XelVHJmxU8ARLiym4HDdV
        TSavywJBHNjdtMgYUl2hYHc/NULutAMXRAg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id STYJTjGcN6-F for <fstests@vger.kernel.org>;
        Wed, 16 Mar 2022 16:20:21 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KJmTc4cK2z1Rvlx;
        Wed, 16 Mar 2022 16:20:20 -0700 (PDT)
Message-ID: <71d35f2c-8522-c076-ce5d-d6d00d9d5309@opensource.wdc.com>
Date:   Thu, 17 Mar 2022 08:20:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] btrfs/237: Use zone cap instead of zone size in fill_size
 and rest calculation
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>
References: <CGME20220315201834eucas1p14717bdbd666dd59b2ef4c86f42bfeb90@eucas1p1.samsung.com>
 <20220315201756.18829-1-p.raghav@samsung.com>
 <20220316040748.j5olvwr4qqpmvqgr@naota-xeon>
 <74e35575-cd2c-07b7-396a-086fc1da2822@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <74e35575-cd2c-07b7-396a-086fc1da2822@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 3/17/22 00:43, Pankaj Raghav wrote:
> Hi Naohiro,
> 
> On 2022-03-16 05:07, Naohiro Aota wrote:
>>> +# blkzone supports printing zone cap only after version 2.37
>>> +_blkzone_req_major_ver=2
>>> +_blkzone_req_minor_ver=37
>>> +blkzone_ver=$($BLKZONE_PROG --version | cut -d " " -f 4 | cut -d "-" -f 1)
>>> +blkzone_ver=( ${blkzone_ver//./ } )
>>> +blkzone_major_ver=${blkzone_ver[0]}
>>> +blkzone_minor_ver=${blkzone_ver[1]}
>>> +if [[ $blkzone_major_ver -ge $_blkzone_req_major_ver &&\
>>> +	$blkzone_minor_ver -ge $_blkzone_req_minor_ver ]]; then
>>
>> I'd like to have it as a helper.
>>
>> Or, how about adding a filter and a wrapper function to add a "cap"
>> filed whose value equal to the zone size for the old version (like
>> with _getcap() and _filter_getcap())? Then, we can just call:
>>   zonecap=$(_blkzone_report ... | grep -Po "cap ([0x\d]+)+" | cut -d ' ' -f 2)
>>   size=$((zonecap << 9))
>>
> That is a good idea. I will give it a shot. Thanks.
> 
>>> +	zonecap=$($BLKZONE_PROG report -c 1 $SCRATCH_DEV |\
>>> +		grep -Po "cap ([0x\d]+)+" | cut -d ' ' -f 2)
>>
>> But still, zone capacity can vary for each zone. So, we need to read
>> the capacity of a zone where the data BG resides on.
>>
> Do we support variable zone capacity in Linux? IIRC variable zone sizes
> are definitely not supported but I am not sure about variable zone capacity.

No, variable zone capacity is not supported in Linux. By that, I mean that
drive that may change the capacity of a zone after a reset are not
supported. So a zone capacity in Linux is always fixed throughout the life
time of the NS it belongs to.

But nothing mandates that all zones have the same capacity. A drive could
expose zones with different capacities. That is the point Naohiro was making.

> 
> But even if we do support, I see that the zone 5 (old_data_zone) and
> zone 6 (new_data_zone) during the test and what if the new_data_zone
> (zone 6) has a smaller cap than old_data_zone (zone 5)?
> The main question: Is there a way to deterministically tell where the
> data BG will reside and where it will relocate before we start the test
> with variable capacity?
> 
> My first look indicates that adding variable zone capacity will make the
> test a bit more complex and I am not sure if it is worth the effort if
> there are no use cases for it.
> Let me know your thoughts.
> 


-- 
Damien Le Moal
Western Digital Research
