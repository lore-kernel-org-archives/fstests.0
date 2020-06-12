Return-Path: <SRS0=NbcK=7Z=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69851C433DF
	for <linux-fstests@archiver.kernel.org>; Fri, 12 Jun 2020 18:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 487AD207F7
	for <linux-fstests@archiver.kernel.org>; Fri, 12 Jun 2020 18:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="2NEp8DwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFLSxg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 12 Jun 2020 14:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLSxg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 12 Jun 2020 14:53:36 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2F6C03E96F
        for <fstests@vger.kernel.org>; Fri, 12 Jun 2020 11:53:36 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j32so7891469qte.10
        for <fstests@vger.kernel.org>; Fri, 12 Jun 2020 11:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iICettaesXrLBNyjieSQFyngYroMDvyTiHPigqCP8P0=;
        b=2NEp8DwU942D7kgoIVF1eCSEPmyvxGjDUfpEDQRXr8OcRNiL59154htLTvUl4ptOoV
         pV9pivXzofwuR8kPCez2ss5meKqwArGkzxOdaP1SQctfXHNe0qe/dcGnSmEVIdKPOfX9
         VYiYe2LzHiMk7r/MU1T3QMRMW0yxSXASv4Jf9tKncB9BZyTZxFYg7tD+WAnNYVA5L8pu
         9V+X1ibCRnXF2nUJB7etfYwMhSagS4kYUqKnDDbLGrTN56Jkcjk7zNmeVfwaQEFKfSHN
         JDLbLeLrfkh5ysZMr6D+gwt9AoocdxDxS8zxupshmR3Ea6IJHG8H712ICSpNQRTh+xy8
         YHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iICettaesXrLBNyjieSQFyngYroMDvyTiHPigqCP8P0=;
        b=ado1MFTcoiT3wBklvA3K+Ta9Zqjyj5vtcgZcKtQHrGgyOgVfeX7aXW0v35fGd4c0e9
         fkoW4MvefBWU3uYAIViNUR1CKVDSpqaGsq+qtP5JfYJHHnLK8o1L0KWhW3nrjuwPgmyD
         5uC0SYsgY7dAJ+HVK6sc0bVEVRQ31GMn+UGAz0MI2KbCqQPgsHlKwb0J3Dk+Jb6HH1PW
         PcXySoEeq43U1BRX4ayItgQW3jUZ7WAk7gP+8JWqhYMuvVpLn64iWRS7kRNOxJ5xoeod
         U+hp8dIOgqElRQPX6pLn1KR4/DbpeIAjDWEUCsyQUh36cGoKOrLul+l5YjaFRkNz/SHw
         q2TQ==
X-Gm-Message-State: AOAM533cxa+mxW7uQQ/MeSFdpwz05Lp8j6ZUZzAe4EK4iIK4+v5BLY5x
        OL211TTUq6/yngZjrNXOYNnW+taGHKxgtw==
X-Google-Smtp-Source: ABdhPJzMSZ406KHo/Fem3i/mDKQoM132caKo9D6mg9ys2xvp3Rhr5gLlYxL+H0s1iOp2ZrSIleLX7Q==
X-Received: by 2002:ac8:378f:: with SMTP id d15mr4597196qtc.136.1591988015791;
        Fri, 12 Jun 2020 11:53:35 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e1::11c4? ([2620:10d:c091:480::1:487c])
        by smtp.gmail.com with ESMTPSA id q24sm5182484qkj.103.2020.06.12.11.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 11:53:35 -0700 (PDT)
Subject: Re: [PATCH] generic/471: adapt test when running on btrfs to avoid
 failure on RWF_NOWAIT write
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20200612140604.2790275-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b231cb6c-6fe9-6ee8-f5cb-3464c791e17c@toxicpanda.com>
Date:   Fri, 12 Jun 2020 14:53:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612140604.2790275-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 6/12/20 10:06 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This test currently always fails on btrfs:
> 
> generic/471 2s ... - output mismatch (see ...results//generic/471.out.bad)
>      --- tests/generic/471.out   2020-06-10 19:29:03.850519863 +0100
>      +++ /home/fdmanana/git/hub/xfstests/results//generic/471.out.bad   ...
>      @@ -2,12 +2,10 @@
>       pwrite: Resource temporarily unavailable
>       wrote 8388608/8388608 bytes at offset 0
>       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>      -RWF_NOWAIT time is within limits.
>      +pwrite: Resource temporarily unavailable
>      +(standard_in) 1: syntax error
>      +RWF_NOWAIT took  seconds
> 
> This is because btrfs is a COW filesystem and an attempt to write into a
> previously written file range allocating a new extent (or multiple).
> The only exceptions are when attempting to write to a file range with a
> preallocated/unwritten extent or when writing to a NOCOW file that has
> extents allocated in the target range already.
> 
> The test currently expects that writing into a previously written file
> range succeeds, but that is not true on btrfs since we are not dealing
> with a NOCOW file. So to make the test pass on btrfs, set the NOCOW bit
> on the file when the filesystem is btrfs.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
