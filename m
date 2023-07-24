Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D017EB64DD
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Jul 2023 18:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjGXSYW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Jul 2023 14:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjGXSYW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Jul 2023 14:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38662127
        for <fstests@vger.kernel.org>; Mon, 24 Jul 2023 11:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690223013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5jHqT74LBzBbNzQ3yq6+erVIVQ4pOAGvC4Knx/Vh83M=;
        b=I9+xOXNk1uXCzX65iAqnrFkXQTfajbX/gv9r+X6u5evv9nnYvRHoLapCLzjcwaHaoaBukR
        5CvqQlbpxgMgCKGaOiFHAZk6KEfxYsGY6oqoX7G5falZc4p9UChuknI6xYkqaZEmxDXCec
        SFHMqq63+2gBEOociqL+W4/WGPWbWtA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-1h3MVA-4PDGDxlPKlTAaVQ-1; Mon, 24 Jul 2023 14:23:31 -0400
X-MC-Unique: 1h3MVA-4PDGDxlPKlTAaVQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31421c900b7so2771592f8f.3
        for <fstests@vger.kernel.org>; Mon, 24 Jul 2023 11:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690223010; x=1690827810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jHqT74LBzBbNzQ3yq6+erVIVQ4pOAGvC4Knx/Vh83M=;
        b=AwQ94tfH1wETYb3rvvDVh7wI1qwoXej42mIivTq+yitVmHwKjmkm3NFuIVHCG9H+BD
         k/hKqarPtAeDICTWVylrTvxq0mZWg7Q1vxPlbyDzUI5qjB1tCMUBh/XZ5Tc4+aF2cH5Z
         lVb3vaSOocn+T3qyzCM7CjK4pqAAybMNZCBU3cDvZOqjQRRETzjVTtNdGe8ESSbXhDfe
         s7/JZ0kqUDFSx5td9nVJmM04HSiMcSM1sS4d31YBpUimxrRKgwi0YhgUAxIs3/EJXueN
         YeQiUgFWuV583IKnGRR37SFqcLuNvnFksKTzaaw5ZiQX2YtP//D7mB12yp6xT/edIrGQ
         IxYQ==
X-Gm-Message-State: ABy/qLa9fUdGd3WuvbRwGUyKcc80qAIZWHAr6gtbO+sIneMfiR2mowKL
        BvUwauHXGR90opC9Tqso1Haugrv74Ud6zluJNLtXnqak7pt0VWHa2URDTlwiOtl+5P4f9RIE1tc
        4Npp1a+cd6syanP0Ky9jofoBZ
X-Received: by 2002:adf:f84b:0:b0:314:377:5e43 with SMTP id d11-20020adff84b000000b0031403775e43mr7628667wrq.48.1690223010062;
        Mon, 24 Jul 2023 11:23:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE97pKdPvOQYsU4TJInTn+mPYkxW1PWjHd8dJ1OmbrPVF4iBMcswdibZ6XxJFPqFlV6YxS08Q==
X-Received: by 2002:adf:f84b:0:b0:314:377:5e43 with SMTP id d11-20020adff84b000000b0031403775e43mr7628661wrq.48.1690223009710;
        Mon, 24 Jul 2023 11:23:29 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id f3-20020a056000128300b0030647449730sm13863738wrx.74.2023.07.24.11.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 11:23:28 -0700 (PDT)
Date:   Mon, 24 Jul 2023 20:23:26 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] generic: add a test for device removal with dirty
 data
Message-ID: <20230724182326.tbrk7nwqukfmsl3k@aalbersh.remote.csb>
References: <20230724152927.33094-1-hch@lst.de>
 <20230724152927.33094-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724152927.33094-2-hch@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 2023-07-24 08:29:26, Christoph Hellwig wrote:
> Test the removal of the underlying device when the file system still
> has dirty data.
> 
> snip
>
> +rm -rf $SCSI_DEBUG_MNT
> +mkdir $SCSI_DEBUG_MNT
> +run_check _mount $SCSI_DEBUG_DEV $SCSI_DEBUG_MNT
> +
> +# create a test file
> +$XFS_IO_PROG -f -c "pwrite 0 1M" $SCSI_DEBUG_MNT/testfile >>$seqres.full
> +
> +# open a file descriptor for reading the file
> +exec 3< $SCSI_DEBUG_MNT/testfile
> +
> +# delete the scsi debug device while it still has dirty data
> +echo 1 > /sys/block/$(_short_dev $SCSI_DEBUG_DEV)/device/delete
> +
> +# try to read from the file, which should give us -EIO
> +cat <&3 > /dev/null

hmm, maybe I missing something but won't cat always return -EIO
here? I suppose the test will also pass without the behaviour you
introduced.

-- 
- Andrey

