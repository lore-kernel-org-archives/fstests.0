Return-Path: <SRS0=bDwJ=33=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825FFC35247
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Feb 2020 00:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5570021775
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Feb 2020 00:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="0wJ2n8U5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgBGAiK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:38:10 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37988 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgBGAiK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Feb 2020 19:38:10 -0500
Received: by mail-qt1-f193.google.com with SMTP id c24so623429qtp.5
        for <fstests@vger.kernel.org>; Thu, 06 Feb 2020 16:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=lll014e4CAaZ3Kz2Y/7ru/mpUQD2fSGN1sJLx1JYegQ=;
        b=0wJ2n8U5xKYBTSofezUYsSR87N+7871HRT0Z44mzLy9SNGlRJw1JDWNGl8G6G+TgzU
         qt6zAhjyeSFuJe+gSh3vuu2dg23YzlyDqM/BzWK8wPfVaJ0Etg9uDn9tDmRTvYrYiZyF
         f99yuE/bBlj99lD4TVxBC2cyYSPp4JE46+TSiH/xbFPF8U6fjLxKcvdQ67SjmFukIkb9
         jIoRLdVKveEDxCazXkeMPRgt0jMaoHv4giAUIyhGLixVyh8aH+sFJ4UPegeeJCUojgKi
         aIfpkxIENn+NK9F589TNt9zi6AtNH5QbIeG2mMex0uEYMh4CQVI0omIUfMvO+SYcJytq
         OhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lll014e4CAaZ3Kz2Y/7ru/mpUQD2fSGN1sJLx1JYegQ=;
        b=LhrL3CyqqWzb+oOfSZHE2pfXUcicTXN7at/4a8Jor0IzVgivtLBhn/kqTrPyB0s96t
         StQlE3emmJkXusCjA+jAonW0lxtmqLH0afbvcsagb8VRAt2wEVZMp1MMGEhc8YAM2+rO
         1ylLqpB0vXf9dIUJgArv8LGwiA3X3bJid1O3rLxYZCaAVKomOEnQwTS108vfX08Gv1lp
         HdaFLOEsWIpjiyPZ0qcHY2JBQCQSM132oZ9mJmU6id6g7H+eBnAQP3bZezx8lZRoh/hx
         4TdllwbTPCH4bNCchYJpOq0MdQn2pbCCCDkIVZp2VPRKCbafWjAPsiIOpp5kc2cXpD12
         sZhw==
X-Gm-Message-State: APjAAAWbFKPZCvMVJhnkSgH+1CELt4OYucnFE1gTC5q3Nt3LimX/1F7G
        4l5Y4rKOZ48cREfxZIaOPbZsoA==
X-Google-Smtp-Source: APXvYqxWO4NUQFH/UFDc1KTASxwppZlSdarfhqxBZbLavh4KAOT9Rh04hCXYXXohEIvcawc4PjWfTw==
X-Received: by 2002:ac8:71d7:: with SMTP id i23mr5264176qtp.50.1581035889485;
        Thu, 06 Feb 2020 16:38:09 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c192sm490696qkg.125.2020.02.06.16.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 16:38:08 -0800 (PST)
Subject: Re: [PATCH] fstests: btrfs/022: Disable snapshot ioctl in fsstress
To:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200206053226.23624-1-wqu@suse.com>
 <e3c530b6-af9d-97de-7008-5bc02c77e037@toxicpanda.com>
 <8199544d-c5cb-eb1e-ed7c-f9b170324997@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7da58abd-eb5e-0a7f-f3bf-205f1daf95cd@toxicpanda.com>
Date:   Thu, 6 Feb 2020 19:38:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <8199544d-c5cb-eb1e-ed7c-f9b170324997@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2/6/20 7:35 PM, Qu Wenruo wrote:
> 
> 
> On 2020/2/6 下午11:47, Josef Bacik wrote:
>> On 2/6/20 12:32 AM, Qu Wenruo wrote:
>>> Since commit fd0830929573 ("fsstress: add the ability to create
>>> snapshots") adds the ability for fsstress to create/delete snapshot and
>>> subvolume, test case btrfs/022 fails as _btrfs_get_subvolid can't
>>> handle multiple subvolumes under the same path.
>>>
>>> So manually disable snapshot/subvolume creation and deletion ioctl in
>>> this
>>> test case. Other qgroup test cases aren't affected.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>> Why not just fix _btrfs_get_subvolid?  You can use egrep to make sure
>> the name matches exactly.  Thanks,
> 
> Because we have other requirement, like limit tests.
> 
> If we have other snapshots/subvolumes, they don't have the same limit,
> thus unable to test qgroup properly.
> 

That's fair, but we should also fix _btrfs_get_subvolid since we know it doesn't 
work in this case.  Thanks,

Josef
