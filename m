Return-Path: <SRS0=Oy/H=CA=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4EDC433DF
	for <linux-fstests@archiver.kernel.org>; Sat, 22 Aug 2020 18:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD862075E
	for <linux-fstests@archiver.kernel.org>; Sat, 22 Aug 2020 18:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vbPpLGrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgHVSFU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 22 Aug 2020 14:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbgHVSFM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 22 Aug 2020 14:05:12 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DB9C061573
        for <fstests@vger.kernel.org>; Sat, 22 Aug 2020 11:05:11 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d22so2697940pfn.5
        for <fstests@vger.kernel.org>; Sat, 22 Aug 2020 11:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ihNBJDNPSWZRuoXh5a+5v17Soc4HFTOTJzR76aNE+O0=;
        b=vbPpLGrDfJeCwpYqjLLxcj4OT7IiNMEK+vXxh2OLzJnQk38gW4F5Mefk5KHGceBuUG
         wDlpv4XTxfyHN2n7NNidRCbT8xoFjtVKYlveD+qVTTdOkmDZCFjgHfcT/UmEIJzveNhm
         QvviDcIHI0rtQCCYGtHnNE4iBDPW9xd/UC2y19AuY+moHyxOLLXT0p2mIYtjs7p68Tpu
         eK4EcdK6MPbqpnu5dYtrqMQVN0VkEvibqhoQeK33YBn6afH9ox2F6jC5h++rGZmp7MPi
         dkQT741HQhqdTEwYqMbabeiEz5m8PG0wT7UVW1bRQLNcXVsvbVoWBD24+7xx1bUXyrRn
         mFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ihNBJDNPSWZRuoXh5a+5v17Soc4HFTOTJzR76aNE+O0=;
        b=OtVfTLZtuWItHVDz9hVuG9/VxeH1lzCDgbolUwfojrrlGO7ajHvROogIQDGIQ+mS6m
         did3d18Z/LC3inZNUY9YOje6/KIInN/frGHNXL/x+yMGCab2RC4179az2mK9XaUjDOT5
         KgsXCNGnky+aGZwhpltATp+R/UOfQ2l88/tvFGTT37gj7w5ZjncSEv47eCZ0LwbI/8UA
         sUsddbSGEWVB0KQrYt2b32M9se5ZIHn5bnv9br2tdF5m07Fkyrgb6q0JQUkS7U9Gxtvb
         WBMEmOFWEilZ7TeSd4OXWMyoo+fIYhJo4eBBePMLoyxtX2pA/yEr7ai17AHZf95NL083
         IMmg==
X-Gm-Message-State: AOAM530p7fPp/ioxA+zm2X82gH+9EeX720j+w7vXATyG8kl2FdqZtTPO
        8/wzZUCXjV17Jm2FA2l1jgmAtzt4ZQ5/tCPQ
X-Google-Smtp-Source: ABdhPJxOP6OJTTFVgEeCMuLru8GvBVOpXTB4PV/+kergfc3Qb0DZIXZBZui6BFwjVPttn/2KGhCL7Q==
X-Received: by 2002:a63:3850:: with SMTP id h16mr5980618pgn.218.1598119511153;
        Sat, 22 Aug 2020 11:05:11 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id u14sm6164124pfm.103.2020.08.22.11.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 11:05:10 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] fsstress: add IO_URING read and write operations
To:     fstests@vger.kernel.org, io-uring@vger.kernel.org,
        jmoyer@redhat.com
References: <20200809063040.15521-1-zlang@redhat.com>
 <20200809063040.15521-2-zlang@redhat.com>
 <01c7353f-338b-99cd-d7d1-fe92b0badd84@kernel.dk>
 <20200822181445.GS2937@dhcp-12-102.nay.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7739965c-e7a0-62a7-9c9e-1178bf280af0@kernel.dk>
Date:   Sat, 22 Aug 2020 12:05:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200822181445.GS2937@dhcp-12-102.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 8/22/20 12:14 PM, Zorro Lang wrote:
>>> +	if ((e = io_uring_submit(&ring)) != 1) {
>>> +		if (v)
>>> +			printf("%d/%d: %s - io_uring_submit failed %d\n", procid, opno,
>>> +			       iswrite ? "uring_write" : "uring_read", e);
>>> +		goto uring_out1;
>>> +	}
>>> +	if ((e = io_uring_wait_cqe(&ring, &cqe)) < 0) {
>>> +		if (v)
>>> +			printf("%d/%d: %s - io_uring_wait_cqe failed %d\n", procid, opno,
>>> +			       iswrite ? "uring_write" : "uring_read", e);
>>> +		goto uring_out1;
>>> +	}
>>
>> You could use io_uring_submit_and_wait() here, that'll save a system
>> call for sync IO. Same comment goes for 4/4.
> 
> Hi Jens,
> 
> Sorry I think I haven't learned about io_uring enough, why the
> io_uring_submit_and_wait can save a system call? Is it same with
> io_uring_submit(), except a wait_nr ? The io_uring_wait_cqe() and
> io_uring_cqe_seen() are still needed, right?

If you just call io_uring_submit(), it'll enter the kernel and submit
that IO. Then right after that you're saying "I want to wait for
completion of a request", which is then another system call. If you do
io_uring_submit_and_wait() you're entering the kernel with the intent of
"submit my request(s), and wait for N requests" hence only doing a
single system call even though it's an async interface.

Nothing else changes, io_uring_wait_cqe() will not enter the kernel if a
cqe is available in the ring already.

-- 
Jens Axboe

