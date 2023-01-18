Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A578FC004D4
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Jan 2023 09:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjARJM1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 Jan 2023 04:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjARJLO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Jan 2023 04:11:14 -0500
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264406B9AD
        for <fstests@vger.kernel.org>; Wed, 18 Jan 2023 00:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1674030561; i=@fujitsu.com;
        bh=JNuzTBnr5JUWbKzaBPFlYbcK14IGGak3DO8EdWmaIXQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=Pqg6rWqZvLzZ7LpBhu15wVD+5m5nN4C32aT6OK5FCPoM3aHaAF+ljtcgQSYLiZpr0
         wKX8xB3LGTVCwaC6TQPkqBRn1D+RGiJgs+WLXOM/juFhwWyOvVc7NxiojSp8UivB4m
         uVrr+Wt1lkK3a01skNpUorMTNHQ4A4/wr9UCfxI6okY3S5oty+FdfoW3Iy1eje1Pz5
         A7qSy6lhG9dZRGYM+woEX8AkC36whScdjsE/cmN15UffYWlTaM1c7ahldhCfRadUl+
         /K6qSss0yAg5p5f6jXgKCodlD2IJ4fDL05dIrS5q6M1XBbXsN0LDdqgxEn1hxXxIuM
         idCb85YHZsofg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRWlGSWpSXmKPExsViZ8ORpPtg7fF
  kg6UfhC0uP+GzON2yl91i/9FHLA7MHptWdbJ5fN4kF8AUxZqZl5RfkcCa0bKumbFgCXPFpbt7
  2RoYzzF1MXJxCAlsZJS42beADcJZyiSxtmsVcxcjJ5CznVHi+XxrEJtXwE5i4uJp7CA2i4Cqx
  NJ7N9gh4oISJ2c+YQGxRQWSJK5uuMsKYgsLeElc6XzGBGKLCGhKHPl2DcxmFoiXuP52IdSyDY
  wSL5feA0uwCahJ7Jz+EmwQp4CGxP6WC6wQDRYSi98cZIew5SW2v50DdpyEgKJE25J/7BB2pUT
  rh18sELaaxNVzm5gnMArNQnLfLCSjZiEZtYCReRWjaXFqUVlqka6pXlJRZnpGSW5iZo5eYpVu
  ol5qqW55anGJrqFeYnmxXmpxsV5xZW5yTopeXmrJJkZgHKQUM5btYOxe9kfvEKMkB5OSKO/r2
  OPJQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4r88GygkWpaanVqRl5gBjEiYtwcGjJMJrvQYozV
  tckJhbnJkOkTrFqCglzqu3GighAJLIKM2Da4OlgUuMslLCvIwMDAxCPAWpRbmZJajyrxjFORi
  VhHmdVwJN4cnMK4Gb/gpoMRPQYo+SoyCLSxIRUlINTAG1AjVn2pJWcopxMgSZKFVfL+R8cnK5
  rAPrdMPKdb8u/zrAclJ3w/pX58O0t0RPWn/2hdy0nfkJwh0tXgqVod8Ybm3yfbFrqsd3y/7Xz
  g62Xp/5p3TxWDv6zXq8XUjJ/ojynxXG+6ovX9nbmCX5L/vR/dIJTuGi5pXBZ9bf/KDgVXoh4n
  PeTRWmudqnl1/oE0yV/t0t/Gf7QceW9dcn951sEt/59kFwu0TaNt5YjUJuV0XWBc2m/lunJez
  w+7iXgfeG+vptO3re9PEace8/yt/XNS3AIliGaWWb+43JP7NZGF6fOyLO1cpUu9X8xv+fIZ3X
  3opU+c6zvPihuTP3sPPT75l14Z4TzfzzY9z6lFiKMxINtZiLihMBYuO7wn4DAAA=
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-4.tower-585.messagelabs.com!1674030560!485346!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13331 invoked from network); 18 Jan 2023 08:29:20 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-4.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 Jan 2023 08:29:20 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id E32DC1AF;
        Wed, 18 Jan 2023 08:29:19 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id CB2971B4;
        Wed, 18 Jan 2023 08:29:19 +0000 (GMT)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Wed, 18 Jan 2023 08:29:17 +0000
Message-ID: <d3f2d9f3-429d-23d1-751c-70f9916fe0bc@fujitsu.com>
Date:   Wed, 18 Jan 2023 16:29:12 +0800
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
