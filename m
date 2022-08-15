Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBD9C25B08
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Aug 2022 09:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiHOJSc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 15 Aug 2022 05:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiHOJSY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 15 Aug 2022 05:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A39FF21E06
        for <fstests@vger.kernel.org>; Mon, 15 Aug 2022 02:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660555102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YzEAatXqK5JK8Pdw/RfxQTXvV1F1gOUlndcdx4iLrdU=;
        b=fTuMQAYJM7ve2XOaqfZncesoEulY+RvM77+EyAEPE/+w7OcDFe5/P/QGMWjND5W8+re/Br
        bMoZcMLsUhEML3s5Za9RUBh6DK0ZFs43wWTdFNLm3+6IcAaasYYOWynFinCt0xSALCGqq8
        u33R/rFv+3QJ3b0ma6iBPogcQl5yJEY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-446-eazi54b2OIiKD2ny7tzm0A-1; Mon, 15 Aug 2022 05:18:21 -0400
X-MC-Unique: eazi54b2OIiKD2ny7tzm0A-1
Received: by mail-pg1-f197.google.com with SMTP id g186-20020a636bc3000000b0041c3d64031cso2406883pgc.1
        for <fstests@vger.kernel.org>; Mon, 15 Aug 2022 02:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=YzEAatXqK5JK8Pdw/RfxQTXvV1F1gOUlndcdx4iLrdU=;
        b=U6i6HUpS+ZGnv4jEbx5gBDBOgqX0M0+pQmrFs7W31BJdGErG1nTIzONUgtmC5JNWHY
         qwUCNJXnAM9PqBlS4/wvTm5ms2BrYRaLTQOAPrJCcqd/b0J2GZLIhSF+aGsv62bGCfTt
         zvZ9NennyFr8FhplUAi5bo3mrcGKqIUcj9HVPi1S0xhQd+SFiyNTAR9JFu6mHBw0oOWM
         /wWXfaBv5GTalGD+hjQIOVlzvknh1FoF3E+HVr4DfVPp1own7i0aCItY1+nX+1kYNvJY
         pGKpdqkPgw2Majv8TFdIU73Db55ZvkSNW2JCZ3dIN4oWcQpvYQb40F5UuaTltt4F+2Q5
         /PdA==
X-Gm-Message-State: ACgBeo28UEhYjIV0BkfNg5Zc+R9IO0N+UgnHz+hEfYHeMwVxQIscqApS
        vp5+298Zzg4crBnzweodpxPBkzI+Sc3jr5Fi+lz/P834QMFKMgVSQ3LSdKylvAWBxzuf7nF1cqy
        pGKPlVoaqnDWs3nnzjw==
X-Received: by 2002:a63:5f86:0:b0:41c:f1:f494 with SMTP id t128-20020a635f86000000b0041c00f1f494mr13512004pgb.51.1660555100406;
        Mon, 15 Aug 2022 02:18:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4YDWquTXSOMm1jdVzubIv7EShj6C0xfymKBr/e9wAjBfj/MNhGAfZ1BvMKB3jFHoKLk6gs+w==
X-Received: by 2002:a63:5f86:0:b0:41c:f1:f494 with SMTP id t128-20020a635f86000000b0041c00f1f494mr13511990pgb.51.1660555100054;
        Mon, 15 Aug 2022 02:18:20 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d2-20020a631d02000000b0041b823d4179sm5478507pgd.22.2022.08.15.02.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:18:19 -0700 (PDT)
Date:   Mon, 15 Aug 2022 17:18:14 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCHSET v2 0/3] fstests: refactor ext4-specific code
Message-ID: <20220815091814.eybgwyf4bjg6m4dx@zlang-mailbox>
References: <166007884125.3276300.15348421560641051945.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166007884125.3276300.15348421560641051945.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 09, 2022 at 02:00:41PM -0700, Darrick J. Wong wrote:
> Hi all,
> 
> This series aims to make it so that fstests can install device mapper
> filters for external log devices.  Before we can do that, however, we
> need to change fstests to pass the device path of the jbd2 device to
> mount and mkfs.  Before we can do /that/, refactor all the ext4-specific
> code out of common/rc into a separate common/ext4 file.
> 
> v2: fix _scratch_mkfs_sized for ext4, don't clutter up the outputs
> 
> If you're going to start using this mess, you probably ought to just
> pull from my git trees, which are linked below.
> 
> This is an extraordinary way to destroy everything.  Enjoy!
> Comments and questions are, as always, welcome.

Two weeks passed, this patchset is good to me, I'd like to merge this patchset
with "[PATCH 1/1] dmerror: support external log and realtime devices" together
this week.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> --D
> 
> fstests git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=refactor-ext4-helpers
> ---
>  common/config |    4 +
>  common/ext4   |  193 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  common/rc     |  186 ++++---------------------------------------------------
>  common/xfs    |   23 +++++++
>  4 files changed, 233 insertions(+), 173 deletions(-)
>  create mode 100644 common/ext4
> 

