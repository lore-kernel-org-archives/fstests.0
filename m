Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58E3C7EE25
	for <linux-fstests@archiver.kernel.org>; Thu,  8 Jun 2023 09:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjFHJNI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 8 Jun 2023 05:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbjFHJM6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Jun 2023 05:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836441FDA
        for <fstests@vger.kernel.org>; Thu,  8 Jun 2023 02:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686215527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pbqn8+LFRSLaCTgL90B7fRHu7GqM+jBEkk/aC9KqzgE=;
        b=ISm2kBFGQjPj+fR/gyq3Z/uWcQ34UCfjVwin7eUCFZ9jOnbcVKdLGlJmCOW243JpLRVj4r
        yO1ZqV1ZlLKbWmqNL0AIK+9oVQu4VkZDPRJy6/4sa9Tk7TLBcz7yUDUgadKoZ1GCEXam1F
        YLAiNOhZ3eh/coKoABM9IHGBT5/6ZT0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-yWYuD9SyMs-vZx4w8vuI6A-1; Thu, 08 Jun 2023 05:12:05 -0400
X-MC-Unique: yWYuD9SyMs-vZx4w8vuI6A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30c5d31b567so169265f8f.2
        for <fstests@vger.kernel.org>; Thu, 08 Jun 2023 02:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686215524; x=1688807524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pbqn8+LFRSLaCTgL90B7fRHu7GqM+jBEkk/aC9KqzgE=;
        b=M5ZvHF5ce0Pc/cEyclaB+ihuVJAScN/ffcyCYTNHtrO4S0lTxMoafxkW6e0r3sB+6G
         Bt0k+hGxSnXUQASG8L+U1G9/WSx0G6jRzLaR3ymki+xpbu+KcN5VHojZgj1LpFrFNsTd
         IB99CklK5errv6ab/gPY7c3g6yQC9kxtH92N7btCWMsKskLKXIc+V4+6Q0v5TfaplI9m
         ckoi37bC2NScu6TubIRCLDIIqoCxZyVWZH51j/8ikUqRcKlzhW/GnbV65TxxIa8zUFuE
         3ngeE8sw/yojgti679GPwA5xws66rWDCxAIsRSaerkdRgKd+JeeOJ641oWIxKThsMnbu
         HLRA==
X-Gm-Message-State: AC+VfDyLiwp6aoCInj9Z/fGWLiN14FZ7H7t6ZUYXQ2cQl/mB5q4c0/mu
        Z2RGwOduJ8Enu7PcZXAh2R0lC2BT3ooYWdtXsenLsT00M9gA55/f1dGHejsXIVhUzhKSpw3M6Z2
        R+6MqxI84KLHB5HMQiOdXzD4J
X-Received: by 2002:a5d:5010:0:b0:30a:e977:de3d with SMTP id e16-20020a5d5010000000b0030ae977de3dmr5642028wrt.28.1686215524656;
        Thu, 08 Jun 2023 02:12:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6myThSTtYUVMz/4E0w94JvRfrgEBBiG4pMu3izzAQwiVRK5Iz17RZwbIWxH0UJn+vma9wzqA==
X-Received: by 2002:a5d:5010:0:b0:30a:e977:de3d with SMTP id e16-20020a5d5010000000b0030ae977de3dmr5642011wrt.28.1686215524329;
        Thu, 08 Jun 2023 02:12:04 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d6e81000000b0030e5ccaec84sm991434wrz.32.2023.06.08.02.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 02:12:03 -0700 (PDT)
Date:   Thu, 8 Jun 2023 11:12:02 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     zlang@redhat.com, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH 2/3] xfs/155: discard stderr when checking for NEEDSREPAIR
Message-ID: <20230608091202.n4gu2otqcqtdmkos@aalbersh.remote.csb>
References: <168609054262.2590724.13871035450315143622.stgit@frogsfrogsfrogs>
 <168609055400.2590724.12890017891103418739.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168609055400.2590724.12890017891103418739.stgit@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2023-06-06 15:29:14, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This test deliberate crashes xfs_repair midway through writing metadata
> to check that NEEDSREPAIR is always triggered by filesystem writes.
> However, the subsequent scan for the NEEDSREPAIR feature bit prints
> verifier errors to stderr.
> 
> On a filesystem with metadata directories, this leads to the test
> failing with this recorded in the golden output:
> 
> +Metadata CRC error detected at 0x55c0a2dd0d38, xfs_dir3_block block 0xc0/0x1000
> +dir block owner 0x82 doesnt match block 0xbb8cd37e44eb3623
> 
> This isn't specific to metadata directories -- any repair crash could
> leave a metadata structure in a weird state such that starting xfs_db
> will spray verifier errors.  For _check_scratch_xfs_features here, we
> don't care if the filesystem is corrupt; we /only/ care that the
> superblock feature bit is set.  Route all that noise to devnull.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Looks good to me.
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

