Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8A8CE7A8C
	for <linux-fstests@archiver.kernel.org>; Mon, 25 Sep 2023 06:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjIYGga (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 25 Sep 2023 02:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjIYGg3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Sep 2023 02:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BC3B3
        for <fstests@vger.kernel.org>; Sun, 24 Sep 2023 23:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695623738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i1YYbpFs118kf99zhzmzRkzKTOXsWkm5QlprOWgyPU8=;
        b=J9PLBx1+0VlM1E3JacmWDC0QzHQEjKp6x1Am83sSmr+doxIAstml0l01WzbYjfD4ALeHW6
        /qY6WKBpiqMGlufF1heS1JAEClyrrL9xE9w7g+UE1JGNWTpI95a7jmygwwR6gNI2hCpoih
        J7c9wdEbq48uAbaXRgF3vNl9xRq7yd8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-km0dpOaJOPKtsTY725yU9Q-1; Mon, 25 Sep 2023 02:35:35 -0400
X-MC-Unique: km0dpOaJOPKtsTY725yU9Q-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5807fcefe79so1671958a12.1
        for <fstests@vger.kernel.org>; Sun, 24 Sep 2023 23:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695623734; x=1696228534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1YYbpFs118kf99zhzmzRkzKTOXsWkm5QlprOWgyPU8=;
        b=iYmCGxLzdNMnJL+IwlTg1RKdmJdl+lqvNimSheW4BbBQ9XDGsZuSIxXhfqc+MFf2LS
         Kc7Jsd5jiEsbgUcyY6hXiI2M1KFEsp+nWuMkloQifisOkrX2zxe0eMAUsVezdYzS1J/3
         MrJXFN214o4dT80UP3gZUxcz+FIf/48eA3Ncxy+1V/YTfpAW8sod0Ir1+qAR5/onAwig
         RYgfuYuIusfFgVuAF9usbca0iRJsTeHJyBZu/lI42Ydr4ERctGUDfFPZNUM0Mwt9sGEN
         /XLPUktcMsdA43U88hZ7HQERMdGEFeOOBY8MEONnx96cNkyYvtiOdR+VpllkaY1NgAo1
         hmEQ==
X-Gm-Message-State: AOJu0YzNbTjH8wWkA1unuwR0u3hLZUIqnITNmU4iH2Mke10Ixr211ZjO
        rVHBsVJW1rvNs4UCTcEeCrrhCBziDKElnGMjIxtZVcYufGJ18Tm5Ajw9Lvc9tCm4o6cklkxEQNY
        7RfPU1sEYOe9rH2nR8w==
X-Received: by 2002:a05:6300:8083:b0:15e:5952:4fc1 with SMTP id ap3-20020a056300808300b0015e59524fc1mr2604854pzc.29.1695623734703;
        Sun, 24 Sep 2023 23:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnFsLurviJROW+Rwn45qHnB0C1VbzviPVORlZZoy1m5tGPZ2IE2BZ32ATH3LmYNkTVfIK3Yg==
X-Received: by 2002:a05:6300:8083:b0:15e:5952:4fc1 with SMTP id ap3-20020a056300808300b0015e59524fc1mr2604846pzc.29.1695623734295;
        Sun, 24 Sep 2023 23:35:34 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id do17-20020a056a004a1100b00692b0d413c8sm4941640pfb.197.2023.09.24.23.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 23:35:33 -0700 (PDT)
Date:   Mon, 25 Sep 2023 14:35:30 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-unionfs@vger.kernel.org, io-uring@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [xfstests generic/617] fsx io_uring dio starts to fail on
 overlayfs since v6.6-rc1
Message-ID: <20230925063530.m4wpinakby26b6q5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20230924142754.ejwsjen5pvyc32l4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <02c1c68c-61a0-4d93-8619-971c0416b0e6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02c1c68c-61a0-4d93-8619-971c0416b0e6@kernel.dk>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Sep 24, 2023 at 11:52:12AM -0600, Jens Axboe wrote:
> On 9/24/23 8:29 AM, Zorro Lang wrote:
> > Hi,
> > 
> > The generic/617 of fstests is a test case does IO_URING soak direct-IO
> > fsx test, but recently (about from v6.6-rc1 to now) it always fails on
> > overlayfs as [1], no matter the underlying fs is ext4 or xfs. But it
> > never failed on overlay before, likes [2].
> > 
> > So I thought it might be a regression of overlay or io-uring on current v6.6.
> > Please help to review, it's easy to reproduce. My system is Fedora-rawhide/RHEL-9,
> > with upstream mainline linux HEAD=dc912ba91b7e2fa74650a0fc22cccf0e0d50f371.
> > The generic/617.full output as [3].
> 
> It works without overlayfs - would be great if you could include how to
> reproduce this with overlayfs.

Sorry I didn't provide the test steps:

1) git clone git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
2) cd xfstests-dev
3) make -j8  # refer to README, about how to build xfstests
4) vi local.config
# The FSTYP can be other fs, e.g. ext4.
# The TEST_DEV and SCRATCH_DEV can be any local devices you have (even loopdev)
# TEST_DIR and SCRATCH_MNT can be changed too
export FSTYP=xfs
export TEST_DEV=/dev/sda5
export TEST_DIR=/mnt/test
export SCRATCH_DEV=/dev/sda3
export SCRATCH_MNT=/mnt/scratch

5) mkfs.xfs -f /dev/sda5 && mkfs.xfs -f /dev/sda3
6) mkdir -p /mnt/test && mkdir -p /mnt/scratch
7) ./check -overlay generic/617

The step#6 will be failed.

Thanks,
Zorro

> 
> -- 
> Jens Axboe
> 

