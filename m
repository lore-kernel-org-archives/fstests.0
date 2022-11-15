Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E7BC4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Nov 2022 07:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiKOHFX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Nov 2022 02:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiKOHFW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Nov 2022 02:05:22 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5501C1EAC0
        for <fstests@vger.kernel.org>; Mon, 14 Nov 2022 23:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1668495919; i=@fujitsu.com;
        bh=29b6cGB/tqfFRZMq+tL1KCSEsRV1bQ8ALehGbsmW3nM=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=v2ybK3TwuqDz/uQBpkmUhi4UlEz7Wy6yawHfh92Y7yOiWMr9DlezBRkWzxFtWFG+m
         unbhCO2de9m2b32uq0Q6UNSXoIIofZZnYC2D1PtUCDEMx0IqT/tt2MvQa0Hn58l614
         6H//3Zqt7LRzgF9HDQsm+IseQOMQ3zxDlmt+XJhQQ2qrutvijhjw71qLKwvFCnF5/m
         dKg/yYYZKsiBsfP8oSRUCF5NtrlPO738Ht5W3R1UImUNI9dgBCRO+zo9nVSwznXl1a
         Ko/DA+C60ZhweziaIFMjq5f93KyYjEBVlF2q7GndPvaGWAx8y2HeBTsgjy1AMLewHR
         hLq2MzvZwcEvQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleJIrShJLcpLzFFi42Kxs+GYpKtvVZx
  ssCbT4t3nKovLT/gsTrfsZbfYe3InqwOLx6ZVnWwe7/ddZfP4vEkugDmKNTMvKb8igTVjxd2v
  LAXP+Sumnz/C3MDYyNvFyMUhJLCFUWLGus8sXYycQM5yJomOScoQiW2MEndvTGMFSfAK2Ek8e
  d7DBmKzCKhKrPvYwQYRF5Q4OfMJWLOoQJLE1Q13weqFBTIlDm++xQRiiwgoSqz5eZEZxGYWiJ
  c482wnK8SyIol5pzrAbDYBR4l5szaCzeQUsJH43vyeHaLeQmLxm4NQtrzE9rdzwOZIAM1sW/K
  PHcKukJg1q40JwlaTuHpuE/MERqFZSM6bhWTULCSjFjAyr2I0L04tKkst0jU000sqykzPKMlN
  zMzRS6zSTdRLLdXNyy8qydA11EssL9ZLLS7WK67MTc5J0ctLLdnECIyMlOJU5h2Ml5f90TvEK
  MnBpCTKe3dxUbIQX1J+SmVGYnFGfFFpTmrxIUYZDg4lCV4Hi+JkIcGi1PTUirTMHGCUwqQlOH
  iURHh3mQCleYsLEnOLM9MhUqcYdTk+/rm4l1mIJS8/L1VKnPcayAwBkKKM0jy4EbCEcYlRVkq
  Yl5GBgUGIpyC1KDezBFX+FaM4B6OSMK+wKdAUnsy8ErhNr4COYAI64oBfEcgRJYkIKakGJi+u
  Z0ZWdyZk7pe6Ysd1afbZD3f1KoRmLhYrjC/iy1GunHT/gwiPq/WMhWsjzqYyRdQUBQX1MH+rf
  x+Z+U50ctHVt5PT2p+bekhy9GTunNHQNVVlg9zMuQdzo55L92yw0p7APWk+++88u6ZJK3d9uN
  al37+n/NzlGrYftYUHGCPiPky4rllzMqE9btvt6edPnbjYbbj77DVnrdOaoWqcEhUJ6xbkXfb
  aFvzx6TaZ/BPykhJ9t27bu3GyLQz8rnUn7jjPK88t2dOO8snYZkXPORC989O1Tn/zq6vX+TDN
  45pff6eHLfL/Ow5dtzPvNfuLvrBoMr1cvkHhxAaGhi13fnx6XnU/yO/bi7XdPl63mZVYijMSD
  bWYi4oTAVIfa7GTAwAA
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-14.tower-732.messagelabs.com!1668495918!490902!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21220 invoked from network); 15 Nov 2022 07:05:18 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-14.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Nov 2022 07:05:18 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 77BB61000D2;
        Tue, 15 Nov 2022 07:05:18 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 6B08D1000C1;
        Tue, 15 Nov 2022 07:05:18 +0000 (GMT)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 15 Nov 2022 07:05:15 +0000
Message-ID: <1c1b84e5-a33d-199d-dcf2-b4a64d5c6eef@fujitsu.com>
Date:   Tue, 15 Nov 2022 15:05:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] common/dmlogwrites: Extend _log_writes_init() to
 accept the specified length
To:     Zorro Lang <zlang@redhat.com>
CC:     <djwong@kernel.org>, <fstests@vger.kernel.org>,
        <bfoster@redhat.com>, <y-goto@fujitsu.com>
References: <1668414903-13-1-git-send-email-yangx.jy@fujitsu.com>
 <20221114145656.cn5bnvllpwaud2px@zlang-mailbox>
From:   =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
In-Reply-To: <20221114145656.cn5bnvllpwaud2px@zlang-mailbox>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2022/11/14 22:56, Zorro Lang wrote:
> On Mon, Nov 14, 2022 at 08:35:02AM +0000, Xiao Yang wrote:
>> It is unnecssary to always create a dm-log-writes device
>> based on the entire size of the target/underlying device.
>>
>> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
>> ---
> 
> Darrick has given his RVB [1]:
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> I think you can keep it in this V2 patch.

Hi Zorro,

Thanks for your reminder.

As Darrick suggested, I actually added a comment to explain the blkdev 
and length arguments. So I hope Darrick can review it again.

Fortunately, Darrick has added reviewed-by on the v2 patch set. ^_^

Best Regards,
Xiao Yang
> 
> Thanks,
> Zorro
> 
> [1]
> https://lore.kernel.org/fstests/Y3EvUgtux4tP1tdY@magnolia/T/#m83b97790ba6570874f36cd0601747e1b6b155de2
> 
>>   common/dmlogwrites | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/common/dmlogwrites b/common/dmlogwrites
>> index 9fa1c977..c1c85de9 100644
>> --- a/common/dmlogwrites
>> +++ b/common/dmlogwrites
>> @@ -59,14 +59,28 @@ _require_log_writes_dax_mountopt()
>>   	fi
>>   }
>>   
>> +# Set up a dm-log-writes device
>> +#
>> +# blkdev: the specified target device
>> +# length(optional): the mapped length in bytes
>> +# Note that the entire size of the target device will be used
>> +# if length is not specified.
>>   _log_writes_init()
>>   {
>> -	blkdev=$1
>> +	local blkdev=$1
>> +	local length=$2
>> +	local BLK_DEV_SIZE
>>   
>>   	[ -z "$blkdev" ] && _fail \
>>   	"block dev must be specified for _log_writes_init"
>>   
>> -	local BLK_DEV_SIZE=`blockdev --getsz $blkdev`
>> +	if [ -z "$length" ]; then
>> +		BLK_DEV_SIZE=`blockdev --getsz $blkdev`
>> +	else
>> +		local blksz=`blockdev --getss $blkdev`
>> +		BLK_DEV_SIZE=$((length / blksz))
>> +	fi
>> +
>>   	LOGWRITES_NAME=logwrites-test
>>   	LOGWRITES_DMDEV=/dev/mapper/$LOGWRITES_NAME
>>   	LOGWRITES_TABLE="0 $BLK_DEV_SIZE log-writes $blkdev $LOGWRITES_DEV"
>> -- 
>> 2.34.1
>>
> 
