Return-Path: <SRS0=bQMt=4U=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AEBC3F2CD
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Mar 2020 02:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04F5246E6
	for <linux-fstests@archiver.kernel.org>; Tue,  3 Mar 2020 02:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="SgsgA9sc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgCCCvX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:51:23 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:37954 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgCCCvP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 2 Mar 2020 21:51:15 -0500
Received: by mail-qv1-f66.google.com with SMTP id g16so1024587qvz.5
        for <fstests@vger.kernel.org>; Mon, 02 Mar 2020 18:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=INhNpypxq4vk6an/j4ULa2DtiBpnawmazdNXlNoT2tM=;
        b=SgsgA9scsM5C95yPabu4s6RsF86NrgVDUgvx3Kwsd1ztCkvMat4dXDg8mPonmZEqCB
         M3iV4yQMbRA9EyG5VIGVmkezndr8Zxw9yzb9vRhIrbtDE/THtY0jpfWvDFAaQj/QyDtu
         rErp4sEk9Rv+6Ezg5RfqdF9jZGdqwC2VTVxdmebRz5LRxnkaRjIhUIAEOjbJMmZSVBcK
         WGPpygd/wopcg8Jy/7J1kW/YcG6HDyvxnzqjlxK1PTdzvhqbR8Mc7NUE/Emx59pftVpa
         /8rfSNJqY6NC69olFVuqWZYzZaSbqC6R1HHTjccQ+F/gSRMydS+HHa6bnfOx6mRJDYK4
         Gqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=INhNpypxq4vk6an/j4ULa2DtiBpnawmazdNXlNoT2tM=;
        b=W4VqCSbUdMA2OHTRwaEpfMJO8YtKzJsKceBzcpYD+gR5ApY8DRppXhOFqeNQT/JHYF
         FJP5XuiQ950rMMxVrBtKqE9djwPOduS/hfg2hGUp7l/xEPAmRX5tM47oL0mhAi18LhdS
         yfANj2tS2UqLwqs6u7RmyGsQa5OqZNp7nmiT4FZrmoD8XdQffqZ8aDs3wOivxo+T7cqg
         P8lP1AWraUzb3/Ib994nTjHQx+z+gUjHVkNl3wmLzbl6HSDdWRLtpB3wpbRmMKiflWaQ
         Dd3Q4ycaJBRhIpzyBf2t+NeLidT0kpBpodjkHf7G2KL9/sqFj/QYPIRY56TfB4AJOYEG
         QXBA==
X-Gm-Message-State: ANhLgQ2DjIxprnr/UJvNgIMOd44wpKzH/0LgJa/zhcyGxHIF6+JynPCn
        HPBtZdufKi535ETWzkU+IYKg7w==
X-Google-Smtp-Source: ADFU+vskdI9UdX2VODufKHGuLuvihDML2O9SNQSKhJkuHWbxNCem8ss/3UzT4WB7L2MuRLcUV7TYbw==
X-Received: by 2002:ad4:42cd:: with SMTP id f13mr2130594qvr.136.1583203873693;
        Mon, 02 Mar 2020 18:51:13 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::1:d3f2])
        by smtp.gmail.com with ESMTPSA id d9sm11056954qth.34.2020.03.02.18.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 18:51:12 -0800 (PST)
Subject: Re: [PATCH fstests] btrfs: add test for large direct I/O reads w/
 RAID
To:     Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
References: <f9a293a382e81ba55e2a321634cb1548d7f69627.1583186857.git.osandov@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a12ae400-17a5-570b-b809-1aae6820f51d@toxicpanda.com>
Date:   Mon, 2 Mar 2020 21:51:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f9a293a382e81ba55e2a321634cb1548d7f69627.1583186857.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 3/2/20 5:08 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Apparently we don't have any tests which exercise the code path in Btrfs
> that has to split up direct I/Os for RAID stripes. Add one to catch the
> bug fixed by "btrfs: fix RAID direct I/O reads with alternate csums".
> ---

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
