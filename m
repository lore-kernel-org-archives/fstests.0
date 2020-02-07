Return-Path: <SRS0=bDwJ=33=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E574C35247
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Feb 2020 02:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5313B21D7D
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Feb 2020 02:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="BKUv4Vj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgBGCKO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Feb 2020 21:10:14 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44083 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgBGCKN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Feb 2020 21:10:13 -0500
Received: by mail-qk1-f196.google.com with SMTP id v195so733256qkb.11
        for <fstests@vger.kernel.org>; Thu, 06 Feb 2020 18:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Bzp60jIPY0ijpd1Xz7Ps7kvYjlALeehugg4Cz7HfZ+k=;
        b=BKUv4Vj6j3AG3fvwWanDUdWCn+t21VSZGVGOIwSC6Sr4B5IFL5cDosm+k94m068Iem
         EJB+a19B5aRDBnR1OpXQdzV/msdsCPsU880aHc7sxc7rkVNnJzY09tHiphAPQPfwJ2hw
         GkH6m2LXrSk/d80IR5dImMFPtCRGV0n7NzQ66dJzRCxlzNQvuSkic/QAGD2xY6llmXA9
         +RSmJtM95wZrPx3btBb+2XdSzojGrKV/YHa37cNwkeGuZZxzg/v3h9HjC1b4kd6jmBmY
         OLvw2BF78uB/BsRqnMAPRp1oOtsABCOiDBQEil9XSNaOeVRM7WCzw5DWHeD4HDanm804
         2kEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bzp60jIPY0ijpd1Xz7Ps7kvYjlALeehugg4Cz7HfZ+k=;
        b=HFKx+RzfvkdUUqw+BvDtsCrUpyCjbtil7ZTgCwwSv/3p44af1UHKndjXNs11iEtgZD
         mjNa3nqKK4IkIIzbXDJmaDACin3U7NFsjidtvoB8b6kifdj4QYi0aySPCOXRj82AuuUI
         lMQW/jVdH26xJhThnwnecXeiiQWcb/AylPIEypP/Z0DUFeMMUJRBFYTnwS8gF3OT/8DX
         Wbzj1nTNe/hA93K7yKC6KPw+oy1q17bwnK3jsTta1oi36NDbZYCMbtiuQSdX4FVMC+6c
         iqtvk4H8W0VrBXrxGbym6AbkGq/UjRYwgqR4xP3N29B3bFQH0FlsKOLp6p63GmKIUjwk
         SrJw==
X-Gm-Message-State: APjAAAXM6MKyBdKxGwIQ1Zg4sVOlo73KmGtCn5dc+axol7g5z00zVGFw
        3YWiTcdEMPj0aetY1Z1YJcwFYunrA+M=
X-Google-Smtp-Source: APXvYqxl0sis2dUipkaE5wXUOR6R6Wdp1gw954zJ9R/n+WrQ1H6ysCpjvR9jSeBlz+75Yux70uOFYQ==
X-Received: by 2002:a05:620a:996:: with SMTP id x22mr4251711qkx.127.1581041412704;
        Thu, 06 Feb 2020 18:10:12 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b17sm622816qtr.36.2020.02.06.18.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 18:10:12 -0800 (PST)
Subject: Re: [PATCH 2/3] fstests: btrfs/022: Match qgroup id more correctly
To:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200207015942.9079-1-wqu@suse.com>
 <20200207015942.9079-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <99175f4e-00a3-fe9f-7c7f-3c2c87aa31cb@toxicpanda.com>
Date:   Thu, 6 Feb 2020 21:10:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200207015942.9079-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2/6/20 8:59 PM, Qu Wenruo wrote:
> [BUG]
> Btrfs/022 sometimes fails with snapshot's reference mismatch with its
> source.
> 
> [CAUSE]
> Since commit fd0830929573 ("fsstress: add the ability to create
> snapshots") adds the ability for fsstress to create/delete snapshot and
> subvolumes, fsstress will create new subvolumes under test dir.
> 
> For example, we could have the following subvolumes created by fsstress:
> subvol a id=256
> subvol b id=306
> qgroupid         rfer         excl
> --------         ----         ----
> 0/5             16384        16384
> 0/256        13914112        16384
> ...
> 0/263         3080192      2306048 		<< 2 *306* 048
> ...
> 0/306        13914112        16384 		<< 0/ *306
> 
> So when we're greping for subvolid 306, it matches qgroup 0/263 first,
> which has difference size, and caused false alert.
> 
> [FIX]
> Instead of greping "$subvolid" blindly, now grep "0/$subvolid" to catch
> qgroupid correctly, without hitting rfer/excl values.
> 
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
