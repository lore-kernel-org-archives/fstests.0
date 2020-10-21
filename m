Return-Path: <SRS0=vxMy=D4=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F169C55179
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Oct 2020 14:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D5FC22275
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Oct 2020 14:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="htf7OEFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443095AbgJUOj5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 21 Oct 2020 10:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442068AbgJUOj5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Oct 2020 10:39:57 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35EBC0613CE
        for <fstests@vger.kernel.org>; Wed, 21 Oct 2020 07:39:55 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id a23so2605399qkg.13
        for <fstests@vger.kernel.org>; Wed, 21 Oct 2020 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2rWqkhk+c3UyK7GwTf/KmgigGCv4GzRVnWXF7VunzzI=;
        b=htf7OEFTSgZS8qZH4/lqOP7wYbnMeRxW0296NEH2aLgnD6Zdds9m0BoU2dfXOxtpL5
         E97FiR2NL0IyBn+l7044/PgjlFkDK2GWHKRBOcFjRzSZq++Ew/006Jc/Ob+p7Yu1aQSL
         f6hXE+tPYn1DaidTot/eLO+cY+WWmeMOGD0TX508OF4TvK+YAopFtb4DY7JH3DbA9qV9
         r9BLirvmXKkARmJRVtfzu8mGP9T1011NO00ro9qioR/FopFtKynSFErk/p0Y+P14vV/P
         ansH4bCut+RNwL6qFjDfEX21RyYYUyIv+quL5npURohfftzBEur/KSD1RI7AZ2a2AUfq
         vgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2rWqkhk+c3UyK7GwTf/KmgigGCv4GzRVnWXF7VunzzI=;
        b=IHPxawTIuS/ECuNlvhU6S5OkrgzAaBaa8/tEAPfF8KOQws472xSEGs1vArwJjHi4Z8
         GqThB+5l+Vlo9Ys2NnCg8LR2Z2DjxWk4Vux9rPNKqPevXjusYDif6zRSS9vyVlXcVZTa
         LL51epsV9VeqNVyBmV6uLW7EziM8lsr9DTDHEBXq8m7Gr+byueIB9Hz2JbFRVxBDzms/
         dph8oNuqztaGULR0Ld4DYXoggw3I7gazorBqeCdj6t/8CPoHEa+b4M+zpU1kFXjtuDZR
         FWGM69mjwlkE7HCpIboZ7Up6/nYG6vr/xRQrefYKMawMrwW0csaEbnvNMQmHETqQRlvx
         FrQQ==
X-Gm-Message-State: AOAM531yDCNKx3VnmOSMBwcYaWX9BryCDZfWdAdi2bQUcoMCGb6OT6FP
        8zVkMpjKUGNtSUtMOLZUdmBW4w==
X-Google-Smtp-Source: ABdhPJwRB94vPJqLu7AubslW9q7QVb1NOL8SsvlO8nhP/9ej3PdP6g7ApupDkYpb7zoaBEZXXwi/Bg==
X-Received: by 2002:a05:620a:130a:: with SMTP id o10mr3354204qkj.63.1603291195189;
        Wed, 21 Oct 2020 07:39:55 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i20sm1308676qkl.65.2020.10.21.07.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 07:39:54 -0700 (PDT)
Subject: Re: [PATCH] check: fix misspelled variable name for sections
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <9609363e0dfbe7098ded407898b8b78c651dae0f.1603204642.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9976beec-0796-4dd1-4aef-8cba7d9286a5@toxicpanda.com>
Date:   Wed, 21 Oct 2020 10:39:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <9609363e0dfbe7098ded407898b8b78c651dae0f.1603204642.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 10/20/20 10:42 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have some places that refer to the variable OPTIONS_HAVE_SECTIONS
> has OPTIONS_HAVE_SECIONS, obviously a typo. So fix them.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
