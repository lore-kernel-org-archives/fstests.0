Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F819C46467
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Jan 2023 18:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjAJSG6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 Jan 2023 13:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239009AbjAJSFq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Jan 2023 13:05:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE1088DD1
        for <fstests@vger.kernel.org>; Tue, 10 Jan 2023 10:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673373789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zxhaElwagYQZGO/5tIWzmpt0ZJY0nhYYOBGCnWda040=;
        b=C8yYfib/UyMP04rYUlwkE3CthLEhPH7iS6mAUMLgDEqlVm4RbzrXFuj3qdQ0PM+24yOcCq
        NzUa3qanRUKy3vkQC1FEPh9kMp8hfRRXe9hZDcyRGGlwSz3Z6geLK3LzBfLfb7lDLXzfeE
        g4CRiZAp6QbHXbrsGxIgGSqlbjwL0k4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-647-d3p22oIkNZy0NZxyT53pig-1; Tue, 10 Jan 2023 13:03:08 -0500
X-MC-Unique: d3p22oIkNZy0NZxyT53pig-1
Received: by mail-pl1-f200.google.com with SMTP id k18-20020a170902c41200b001896d523dc8so8874624plk.19
        for <fstests@vger.kernel.org>; Tue, 10 Jan 2023 10:03:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxhaElwagYQZGO/5tIWzmpt0ZJY0nhYYOBGCnWda040=;
        b=lcKYWiz/i4prGWqxU+HOt1RROzFbHBR5zWmb6C06KdsPnu2W46kpzadLnLzY0z/26Y
         CbehYO5LTzrXi086M9dHQvYMsB1+yRs+dO+oEmrDA28soNMVsT6bXirU4yhI84ZF75+I
         2e0kv/NAJPKFoYMSjckVci806Ix0DkbdIWzCVk5pBTFBrQNOXjxiddTnMmgyeyoArqZ1
         E0o9MQMN+ykOv72o2698UjtdEQgipoJN7iIfR3m2GZ2eqPQbhenpGuiPDdBduNEeoKoV
         Qdch70Gju4RHutcLT19mdx2UCXqq/+8X1GfFwHTXQdNbzz+vfxuqZbf0WIq728EnA0DF
         cHmQ==
X-Gm-Message-State: AFqh2kpL2lbBqMfkniEtSV8ciRw2WRyBXxSdfavdzP93Qzo7GK1wen67
        Ipl7/Re9nZXFAjE7zFZXGQDRZdFR/bVmZaxzJcPV5rnCMx3PqISY5zFhqKUPp60KqPWkTIyan91
        ad0Lb+thqGsxVYc7hdg==
X-Received: by 2002:aa7:828c:0:b0:57f:eb31:c306 with SMTP id s12-20020aa7828c000000b0057feb31c306mr60421640pfm.1.1673373787303;
        Tue, 10 Jan 2023 10:03:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsQ/NmQjn51BNvkYERMgkbqwuxrcnWVMzX7VzO6eYTlkh7rSAhRp/KYpdFm1NT/v7Zof5ZyWw==
X-Received: by 2002:aa7:828c:0:b0:57f:eb31:c306 with SMTP id s12-20020aa7828c000000b0057feb31c306mr60421621pfm.1.1673373786914;
        Tue, 10 Jan 2023 10:03:06 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 69-20020a621748000000b005810a54fdefsm8408975pfx.114.2023.01.10.10.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 10:03:06 -0800 (PST)
Date:   Wed, 11 Jan 2023 02:03:02 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs/012: check if ext4 is available
Message-ID: <20230110180302.sed3dc62qt6dh4cs@zlang-mailbox>
References: <20230110155216.1809562-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110155216.1809562-1-johannes.thumshirn@wdc.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 10, 2023 at 07:52:16AM -0800, Johannes Thumshirn wrote:
> btrfs/012 is requiring ext4 support to test the conversion, but the test
> case is only checking if mkfs.ext4 is available, not if the filesystem
> driver is actually available on the test host.
> 
> Check if the driver is available as well, before trying to run the test.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---

Looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/012 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/btrfs/012 b/tests/btrfs/012
> index 60461a342545..d9faf81ce1ad 100755
> --- a/tests/btrfs/012
> +++ b/tests/btrfs/012
> @@ -31,6 +31,7 @@ _require_command "$E2FSCK_PROG" e2fsck
>  # ext4 does not support zoned block device
>  _require_non_zoned_device "${SCRATCH_DEV}"
>  _require_loop
> +_require_extra_fs ext4
>  
>  BLOCK_SIZE=`_get_block_size $TEST_DIR`
>  
> -- 
> 2.38.1
> 

