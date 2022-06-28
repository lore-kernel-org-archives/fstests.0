Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9DCC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Jun 2022 04:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiF1E2u (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jun 2022 00:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244840AbiF1E23 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jun 2022 00:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 259EC13D5C
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 21:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656390508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lT9dML198j2jI8sCB1rJkYluCfErFk7E3R2zXLiLwtc=;
        b=dHsUGhDAjCJpGd2pxxm5QNBpjmDuk6HjjOE4TpA2noU3O7NZ0Cdsb9C8k/4xkgHVvII24n
        FJkxoAx1J9/4gXYohGB4DqBZShXEnpemzOeeqglQ2j9mL+M8CPYCBUm/bvYKMvc3z1SLMl
        xS1MfDKJ/tavgAsL3qfivxQj67Bii6E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-dkfAYDgwMT60LtA4-q4Q7g-1; Tue, 28 Jun 2022 00:28:25 -0400
X-MC-Unique: dkfAYDgwMT60LtA4-q4Q7g-1
Received: by mail-qv1-f71.google.com with SMTP id m7-20020ad45dc7000000b0047042480dbfso11179784qvh.9
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 21:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lT9dML198j2jI8sCB1rJkYluCfErFk7E3R2zXLiLwtc=;
        b=vi6GAz1N9fvuMY2KJJN0qurs34SfzTBHzYGhBkO5qqtO9v24rYbhuAynba8jif+xpg
         2r3DrhUV6nmVK6NPfbn5F6x8oQk6V8auzdjTcZZVdeinAYAlh4tqd72APxDUa33gBE/U
         iZEPlsYRJEAX7TkyYDspK3xrXjgE0L9vCC3mfsgWqu0YbO6Tus7kvkKdujJVnxYvUZtf
         IvWIz+E8MYPYVbM/gCZqNYLxwzM/Ro5pt4+6RoWHYkU/MzR43Crpjk/L8boudORaBCMA
         Fd6lCYVPnb5vLi4Nb+em69TDok6TSoTAX8l/lYwJ7edqxwWtCRI65K2dHZp3w0lL4TMw
         9zJw==
X-Gm-Message-State: AJIora9DOKJyf3UA67Dn8PsmQqAuMLUqes5AYTRtg487UBCpKrjPhoeJ
        tfiq604H0nNUtFX0+00Yi8oMNMopILDYPPApAjNTOtP5CQ51wvJp16rbhjFH0VonQf3RaIqDlsb
        ascorf/NCvR/uj1fhRg==
X-Received: by 2002:ac8:59c8:0:b0:31a:576f:13f9 with SMTP id f8-20020ac859c8000000b0031a576f13f9mr6421212qtf.596.1656390504530;
        Mon, 27 Jun 2022 21:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uqO69sQtIHzVWPm33MJuJF341Ab/cVZ/bWfHvEQI91Kf2WGYtWjTa+xQ+cJvO6tGernYvqhg==
X-Received: by 2002:ac8:59c8:0:b0:31a:576f:13f9 with SMTP id f8-20020ac859c8000000b0031a576f13f9mr6421199qtf.596.1656390504260;
        Mon, 27 Jun 2022 21:28:24 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c24-20020ac853d8000000b003171a5dc474sm8202767qtq.23.2022.06.27.21.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 21:28:23 -0700 (PDT)
Date:   Tue, 28 Jun 2022 12:28:17 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/5] ext4/044: skip test if the file system does not have
 a journal
Message-ID: <20220628042817.2xxzleisfguoq7qh@zlang-mailbox>
References: <20220625030718.1215980-1-tytso@mit.edu>
 <20220625030718.1215980-3-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625030718.1215980-3-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 24, 2022 at 11:07:15PM -0400, Theodore Ts'o wrote:
> This test mounts the file system using "mount -t ext3"; if the file
> system config creates the file system without the jbd2 journal, the
> "mount -t ext3" will fail.  So skip this test in that case.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/ext4/044 | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/ext4/044 b/tests/ext4/044
> index 46e44053..fd27ae2d 100755
> --- a/tests/ext4/044
> +++ b/tests/ext4/044
> @@ -16,11 +16,17 @@ _begin_fstest auto quick
>  _supported_fs ext4
>  _require_scratch
>  _require_test_program "t_get_file_time"
> +_require_dumpe2fs
>  
>  echo "Silence is golden"
>  
>  echo "Test timestamps with 256 inode size one device $SCRATCH_DEV" >$seqres.full
>  _scratch_mkfs -t ext3 -I 256 >> $seqres.full 2>&1
> +
> +$DUMPE2FS_PROG -h $SCRATCH_DEV 2>> $seqres.full | grep '^Filesystem features' | grep -q has_journal
> +if [ $? -ne 0 ]; then
> +    _notrun "ext4 file system formatted without a journal"
> +fi

Can _has_metadata_journaling help that?

Thanks,
Zorro

>  _scratch_mount
>  
>  # Create file
> -- 
> 2.31.0
> 

