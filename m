Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C975CC4332F
	for <linux-fstests@archiver.kernel.org>; Sat, 12 Nov 2022 05:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiKLFsS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 12 Nov 2022 00:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKLFsR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 12 Nov 2022 00:48:17 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072D4C29
        for <fstests@vger.kernel.org>; Fri, 11 Nov 2022 21:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1668232094; i=@fujitsu.com;
        bh=GklClfd+K6brbTZxna9KDHqi9SEizaHdrjuaWK61mZA=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=ghdOsDPD73aX4DX189f3xZ3Dhb98cBFORgZsTPmsY9UGAStNO240kAX0mTAJ18dLG
         hioNkepryaLEU+Ga00AQZstZUkt0ezpXLm1ofnmv4cO88GzYTg+iQqoiPFnTXOL3yE
         i4pfQonTrqaV/eiGeriX+RkiUsheNI8JJ6PavctwM8wUoFkSSOPHsf2eShZlPulfO6
         Onb3KMNK3nJndm/orRCtDx06B5ScxTD9MplEa+Hrl/fHhdLIFMNLAJ+e5NkANcfYwC
         aH6D1DDK49zMExF4CYBBoI75UI+k+HB+gq9jD6FaKQMvwbTDANwXpD3CZ73OnSP9lq
         jbiRAtWnmKxjg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRWlGSWpSXmKPExsViZ8ORpDvXOD/
  ZYFG1xbvPVRaXn/BZnG7Zy26x9+ROVgcWj02rOtk83u+7yubxeZNcAHMUa2ZeUn5FAmvG8i+e
  BfNEK74dvcjewPhesIuRi0NIYCOjRPubdaxdjJxAzhImieVrEiDsbYwSyz7kg9i8AnYSS2+cZ
  AKxWQRUJXYc3cwOEReUODnzCQuILSqQJHF1w12wOcICIRLbXzWwgdgiApoSR75dYwJZxizQxS
  hx+ugBZojNK5kk3k3awQhSxSbgKDFv1kawDk4BDYnm951gcWYBC4nFbw6yQ9jyEs1bZzOD2BI
  CihJtS/6xQ9gVErNmtTFB2GoSV89tYp7AKDQLyYGzkIyahWTUAkbmVYxmxalFZalFuqZ6SUWZ
  6RkluYmZOXqJVbqJeqmlunn5RSUZuoZ6ieXFeqnFxXrFlbnJOSl6eaklmxiBcZFSnOC0g3HKs
  j96hxglOZiURHnfc+QnC/El5adUZiQWZ8QXleakFh9ilOHgUJLgPaAPlBMsSk1PrUjLzAHGKE
  xagoNHSYTXmQcozVtckJhbnJkOkTrFqCglznvJACghAJLIKM2Da4OlhUuMslLCvIwMDAxCPAW
  pRbmZJajyrxjFORiVhHkbjYCm8GTmlcBNfwW0mAlo8ffIPJDFJYkIKakGpjrG1eL1b3fcswuZ
  5/wqzH2uv/1r3fjj2pdv6P87cLa7L3blxIlf1x5jdnmfv32Ry1+FKa/3aPeEnJu6ZAp3sP1J8
  fZDpTrpd9Si/ipf+5zMonPlzPsvbyMZbOuEOWXETzlvc7U1C+tZ1WvxvZWnRiUk7Pia8iafe2
  clknlC9F8/tbmbeXrhDcPrs1uLfxiUVC3vm5SxqSbj5PIX//Zvn8D14xmjkM+NV5pzj5476tw
  jnft+9SSLLh3LiLTiZZ3nbm5N4Uue+mdxYoD9JSfuGbtZq7u5rG8KP9SaxVp/8Nv8717Tv7Hc
  P+Nz0OtTvJ2PYthfS1/pFaIB5+Zzn//BxV3RIPrmmlZNWvSVMvfjMkosxRmJhlrMRcWJALzjI
  sCGAwAA
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-8.tower-745.messagelabs.com!1668232092!636392!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17804 invoked from network); 12 Nov 2022 05:48:12 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-8.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Nov 2022 05:48:12 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 49D061B1;
        Sat, 12 Nov 2022 05:48:12 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 3EB511AD;
        Sat, 12 Nov 2022 05:48:12 +0000 (GMT)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sat, 12 Nov 2022 05:48:09 +0000
Message-ID: <cd5b27c9-0af1-e3da-e896-7946154f35ad@fujitsu.com>
Date:   Sat, 12 Nov 2022 13:48:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND 2/2] generic/470: Replace thin volume with
 blkdiscard -z
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "zlang@redhat.com" <zlang@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>
References: <20221023064810.847110-1-yangx.jy@fujitsu.com>
 <20221023064810.847110-2-yangx.jy@fujitsu.com> <Y1YP7ehSZUdVS4/J@magnolia>
 <ddc1978f-686e-de66-71bf-b39dbafc2a9d@fujitsu.com>
 <OS3PR01MB94990061DFD4223EC681B0AF83349@OS3PR01MB9499.jpnprd01.prod.outlook.com>
 <Y2CW/n8R4xBklb3x@magnolia>
From:   =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
In-Reply-To: <Y2CW/n8R4xBklb3x@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2022/11/1 11:48, Darrick J. Wong wrote:
> On Sun, Oct 30, 2022 at 07:30:31AM +0000, yangx.jy@fujitsu.com wrote:
>> Hi Darrick,
>>
>> Ping, is there any feedback on the patch?
>>
>> Best Regards,
>> Xiao Yang
>>
>> -----Original Message-----
>> From: Yang, Xiao/杨 晓 <yangx.jy@fujitsu.com>
>> Sent: 2022年10月24日 15:16
>> To: Darrick J. Wong <djwong@kernel.org>
>> Cc: zlang@redhat.com; fstests@vger.kernel.org; bfoster@redhat.com
>> Subject: Re: [PATCH RESEND 2/2] generic/470: Replace thin volume with blkdiscard -z
>>
>> On 2022/10/24 12:09, Darrick J. Wong wrote:
>>> On Sun, Oct 23, 2022 at 06:48:13AM +0000,yangx.jy@fujitsu.com  wrote:
>>>> generic/470 was original designed to verify mmap(MAP_SYNC) which is
>>>> only vaild to the DAX capable device(e.g. PMEM). Thin volume[1] was
>>>> introduced to fix the inconsistent filesystem issue[2] but it make
>>>> the test become not run because it doesn't support DAX. As Darrick
>>>> mentioned[3], discarding the entire mapped range of scartch device
>>>> can fix the issue as well, so I try to use blkdiscard -z instead.
>>> That might be ok for the*other*  dm-logwrites tests, but isn't the
>>> fundamental problem here (generic/470, specifically) that device
>>> mapper cannot run on top of pmem?
>>
>> Hi Darrick,
>>
>> With the change，I didn't find any failure when running generic/470 in loops.
>> --------------------------------------------------------------
>> [root@fedora35 xfstests-dev]# ./check generic/470
>> FSTYP         -- xfs (non-debug)
>> PLATFORM      -- Linux/x86_64 fedora35 6.1.0-rc1+ #37 SMP
>> PREEMPT_DYNAMIC Fri Oct 21 19:04:57 CST 2022 MKFS_OPTIONS  -- -f /dev/pmem0 MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/pmem0 /mnt/scratch
>>
>> generic/470 6s
>> Ran: generic/470
>> Passed all 1 tests
>> --------------------------------------------------------------
>> Both dm-log-writes and PMEM support DAX so it's fine to verify
>> mmap(MAP_SYNC) with the dm-log-writes device on top of PMEM.
>>
>> Did I miss something? Why do you think there is a fundamental problem here?
> 
> Nope, you're right.  fsdax works fine, at least on these simple(r)
> device mapper devices:
> 
> $ git grep -c dax drivers/md/
> drivers/md/dm-core.h:1
> drivers/md/dm-linear.c:19
> drivers/md/dm-log-writes.c:19
> drivers/md/dm-stripe.c:19
> drivers/md/dm-table.c:18
> drivers/md/dm-target.c:4
> drivers/md/dm-writecache.c:7
> drivers/md/dm.c:36
> 
> (Most notably, dm-logwrites :))
> 
> I'll go look at the test in the morning.

Hi Darrick,

Do you have time to look at it?
I hope you can give me reviewed-by if you think this patch set is OK.

Best Regards,
Xiao Yang

> 
> --D
> 
>> Best Regards,
>> Xiao Yang
>>
>>>
>>> --D
>>>
