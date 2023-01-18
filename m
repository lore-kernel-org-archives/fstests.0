Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA730C004D4
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Jan 2023 09:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjARJGW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 Jan 2023 04:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjARJEf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Jan 2023 04:04:35 -0500
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C0A3D930
        for <fstests@vger.kernel.org>; Wed, 18 Jan 2023 00:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1674030266; i=@fujitsu.com;
        bh=JNuzTBnr5JUWbKzaBPFlYbcK14IGGak3DO8EdWmaIXQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=oVhxCAeuUpJqw/8NPL8Sas2//mp7RoPDR7kDmvIVStcY5pMSd4iImm4s4bi3ZHatL
         x+JFVb1GTzq/0CITu3YHduKlhp/Gdvii/6iBPLOLM+l53kd3gjBknFr40ez2c7BFA8
         /G7WFERCbfPqWFQJomdzW9JXKAN5AbsBU/2TRpwAIqpdhK8361K0mi+cV+YZU/i2fM
         MgzHC62GcEblRPW0BvOB8NIJLmXOXSJXGIebb+qqvWO6JqKnpGuZhUQqov0wYF2DhK
         kPhR7ympysJ9i/fdg+VEsQKwqZf43ME2FBiMnXOBH3nRmP/l7N3Bu5Ydop57WIJ6V6
         Q0cWkvfZqhqwg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRWlGSWpSXmKPExsViZ8OxWXfXmuP
  JBg0nhSwuP+GzON2yl91i/9FHLA7MHptWdbJ5fN4kF8AUxZqZl5RfkcCa0bKumbFgCXPFpbt7
  2RoYzzF1MXJxCAlsYJR4fOkvSxcjJ5CzlEliy19xiMR2RokFnx6ygyR4BewkTm14xwxiswioS
  vzd8wkqLihxcuYTsGZRgSSJqxvusoLYwgJeElc6nzGB2CICmhJHvl0Ds5kF4iWuv13IBrf55d
  J7YAk2ATWJndNfgg3iFNCQ2N9ygRWiwUJi8ZuD7BC2vMT2t3PAjpAQUJRoW/KPHcKulGj98Is
  FwlaTuHpuE/MERqFZSO6bhWTULCSjFjAyr2I0LU4tKkst0jXXSyrKTM8oyU3MzNFLrNJN1Est
  1S1PLS7RNdRLLC/WSy0u1iuuzE3OSdHLSy3ZxAiMg5RixtwdjDuX/dE7xCjJwaQkyvs69niyE
  F9SfkplRmJxRnxRaU5q8SFGGQ4OJQne67OBcoJFqempFWmZOcCYhElLcPAoifBaA+NSiLe4ID
  G3ODMdInWKUVFKnFdvNVBCACSRUZoH1wZLA5cYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfM
  6rwSawpOZVwI3/RXQYiagxR4lR0EWlyQipKQamA5YeSXb3ZnLYnL7i5TBv9tO8l8S5979lTpr
  4un6PafZ3KbPiHv9Mn0a+/SzthvmFO6b7+4txCufVa49e4rYEpbHRSrb6+3WXGacoHbXP/1nR
  1mbsMafA/IzxWZzKD/5ybGBo8lErlQ5sHXrqqka0tc+Vi63j/0Rcqi0+RPXVbFZsTXn0/lXfq
  2duEJE5YlAacXKH9J81iEcT13OnTuRYn2Uo/fr8ZRCD54N/j/cb59O41H1q4s0kArOXaO2wnI
  mx6tbhwtlvi96xflv/5WJAkLMJmum3X933G77rvmKYUwTXHs3f0tI59hyXNO6YueFoxZW/5Xd
  nOx5+W6eOambuOaxfsHBI/dvCbuyWTBPTlRiKc5INNRiLipOBAC+7G2vfgMAAA==
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-3.tower-585.messagelabs.com!1674030266!484163!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19740 invoked from network); 18 Jan 2023 08:24:26 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-3.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 Jan 2023 08:24:26 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id E09DE73;
        Wed, 18 Jan 2023 08:24:25 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id D37AA150;
        Wed, 18 Jan 2023 08:24:25 +0000 (GMT)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Wed, 18 Jan 2023 08:24:23 +0000
Message-ID: <3d7aacc3-f6d7-3f97-0f1a-75b0f3fc99b7@fujitsu.com>
Date:   Wed, 18 Jan 2023 16:24:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] xfs/440: skip test if the dax mount option is enabled
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "zlang@kernel.org" <zlang@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <1671790916-13-1-git-send-email-yangx.jy@fujitsu.com>
 <OS3PR01MB9499E00F5D2C42FCF847D81F83C29@OS3PR01MB9499.jpnprd01.prod.outlook.com>
 <Y8HOD3P3l5nnPJO+@magnolia>
From:   Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <Y8HOD3P3l5nnPJO+@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2023/1/14 5:33, Darrick J. Wong wrote:
> On Fri, Jan 13, 2023 at 04:53:41AM +0000,yangx.jy@fujitsu.com  wrote:
>> Hi Darrick,
>>
>> Is there any comment on the patch?
> What happens if you set DAXINHERIT on the root directory and omit the
> mount options?  Does it still fail?
Hi Darrick,

Yes, it still failed.  I have reviewed your patch set fixing the issue.

Thanks a lot.

Best Regards,
Xiao Yang
> 
> --D
> 
> 
