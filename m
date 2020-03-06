Return-Path: <SRS0=xM/5=4X=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA719C10F00
	for <linux-fstests@archiver.kernel.org>; Fri,  6 Mar 2020 14:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FC02084E
	for <linux-fstests@archiver.kernel.org>; Fri,  6 Mar 2020 14:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="cT08tfQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCFOxX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:53:23 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35806 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgCFOxX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 Mar 2020 09:53:23 -0500
Received: by mail-qt1-f193.google.com with SMTP id v15so1902962qto.2
        for <fstests@vger.kernel.org>; Fri, 06 Mar 2020 06:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B5dVCsBLlpcPciBlxV6XUOyQP4hX4NakGhhdj+WALw8=;
        b=cT08tfQp0bx4R2WHgyxvRZSmsjY5Z0A/WfezRe346NhEzsidUPH1t6A8D6Lh+99ZOo
         NW19usviJkMb0Bttew2c21doD9KtyHZ7/auO/gMrE0vL9G6ysttOFtpNTwmsZ3QYagvS
         u5kNTCbK8an5tlGC+T/EgOHylF2HFtKA/SxQOhZ563rfUKqG2YtjJtQtK9yUPCVzYnM/
         TD+vXjCaJlvt8Qanc/CIXBcngHjdFyG8Bd1k5k2INBlzEjGVqRDZQNZglNF11vdsumvf
         ZpZOXVz6BgoYtTGOVotvPuT7QhFXA4R/QtMdUibo7hOcCGaPr9B+DlJk1qW+U8Y75xzF
         ODBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B5dVCsBLlpcPciBlxV6XUOyQP4hX4NakGhhdj+WALw8=;
        b=C2Z2LujWjG7LVy7g8/guGP5wR5x0WmVHBz3RMRsi9QiJyhavcCVuspfNgIgTlqGQW2
         k/K4T/LR0Dw28RouzniPayXlQ3UCYb9Nr8eoZ2MdUVlHmVfb0eeWp4m0Vk6s9wOzlAW+
         y9uYhI0ckVfxdu6+i7pCsn0l6zgyHPfwRyPnOGfcZL6bjQVRJfqolWyrk2E5QsJEJYEf
         4snoukdrFHihP8LzseC67zn3bOYOoxrvvieNFZUSl3D9vPXYqyQy7Y2UXgguGJqYa1C2
         c3Na8Z1lJWVU448jEDHXFovuElSRthcOLpsGyxxwS3isXoxd6CbhKwWw3fbm3YX3e5N/
         bb9A==
X-Gm-Message-State: ANhLgQ3NhG3JsH+zwwpn2UcertVr2ok2gnWs4eW9lnygz4UMOxmH28Xb
        FUOgEkJzs+jDRKHa3xFxeglmXw==
X-Google-Smtp-Source: ADFU+vvuaJjW09CHPk3NAH0y9c7WE0URkuiFlewQVMz7Q7Z20qQP2Ihcy0wzwm0eU3j66jHiy/gXfg==
X-Received: by 2002:ac8:7955:: with SMTP id r21mr3175979qtt.289.1583506400930;
        Fri, 06 Mar 2020 06:53:20 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x44sm16744069qtc.88.2020.03.06.06.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 06:53:20 -0800 (PST)
Subject: Re: [PATCH] fsx: fix bug where zero range operations never use the
 keep size flag
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20200306123517.16729-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <56679ef6-4f41-63a8-9ab5-941b22143924@toxicpanda.com>
Date:   Fri, 6 Mar 2020 09:53:19 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306123517.16729-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 3/6/20 7:35 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We are never using the FALLOC_FL_KEEP_SIZE flag for zero range operations
> even when we intend to use it. So fix it by setting that flag for the
> call to fallocate(2) if the 'keep_size' parameter is true.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
