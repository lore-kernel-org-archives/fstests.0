Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB38ECAAD3
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Sep 2022 04:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiIOEHZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 15 Sep 2022 00:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIOEHY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Sep 2022 00:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB368E0EF
        for <fstests@vger.kernel.org>; Wed, 14 Sep 2022 21:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663214841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0m3Ap1Gw8JucASnyAU6wojyipNSv+mWAPE/c41uS9pU=;
        b=Oz7CU7IwJ5Kgqw2ICpESt9bommlmEcMVi3P65Mrj7YKZgyl6tzFLsSgo4NcSrzz4vj0jR7
        n3+SCgtAJnGj9oJuGyYzobj1qcjiupmaV1jWjpIwgyDdqWpzBCEUmrsamWlHwaW/tAlXc6
        Tcwo4jWwTH+e4fGtD0pd2ALV99NJTPo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-646-pXzBh27eN92yamUXnxcZ0w-1; Thu, 15 Sep 2022 00:07:20 -0400
X-MC-Unique: pXzBh27eN92yamUXnxcZ0w-1
Received: by mail-qv1-f72.google.com with SMTP id nl18-20020a056214369200b004ac52c4b0a4so11948319qvb.13
        for <fstests@vger.kernel.org>; Wed, 14 Sep 2022 21:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0m3Ap1Gw8JucASnyAU6wojyipNSv+mWAPE/c41uS9pU=;
        b=sBUSodYhgQcdSAv16xs2SXJoRJM82I3VoHfEkPfNseUvJVhQehc0rIPEW3I+96wH6d
         sxXisKhaPDQA8uE9uCAAxZmBv6ubvb7ufNaPfEmiAbI4VtGb9NpFEYOoG8HGLMITskZl
         rKm+ew+I3AZciC4WWV0XxHTGGDiLnJM4OHl5rGXLm8AXxKclJP0QbjWguC+1++KPeIyz
         i7abBISfo74zkHdQFH0fTJTGxmB6l2i6iveuFpkgX2FHpLy7bQPV80K7Fqp+P1kMfLbw
         fe6ZgGPpKmOmCyAQaaaCYvq/onACrb2G9pJL8FmR5gpi9yamw4tp4JhlxYO0NZGoUYsB
         /n5Q==
X-Gm-Message-State: ACgBeo2oKm3aBqQ85EdFxV88XcH2rU7c3zXMpzcdLPBHMlCWVclYFHMK
        oje7LmOCgd2wKfPEl0tCjmC3Tp1rE3MCA6lrP8NypwPS2qRgafaYxrNB++qN3PY5i9znVgvmjZI
        ic8xUR9ctybOcOZ7qzQ==
X-Received: by 2002:a05:6214:2129:b0:4ac:8dfe:9d82 with SMTP id r9-20020a056214212900b004ac8dfe9d82mr24174390qvc.98.1663214839966;
        Wed, 14 Sep 2022 21:07:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Ci+dp2yUmu6+t0fuRdeXc4h7bCNv6FULVH5kavXq2fGuy+9JdC+nvIWzsLTlUbx/WuFakTA==
X-Received: by 2002:a05:6214:2129:b0:4ac:8dfe:9d82 with SMTP id r9-20020a056214212900b004ac8dfe9d82mr24174375qvc.98.1663214839715;
        Wed, 14 Sep 2022 21:07:19 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bs14-20020a05620a470e00b006b58d8f6181sm3200479qkb.72.2022.09.14.21.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 21:07:19 -0700 (PDT)
Date:   Thu, 15 Sep 2022 12:07:14 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Pavel Reichl <preichl@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/1] generic: test i_blocks for truncated large files
Message-ID: <20220915040714.lnbuixu32lgowxic@zlang-mailbox>
References: <20220913125801.56366-1-preichl@redhat.com>
 <20220913125801.56366-2-preichl@redhat.com>
 <YyIWjArO7bvCJQLM@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyIWjArO7bvCJQLM@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Sep 14, 2022 at 10:59:40AM -0700, Darrick J. Wong wrote:
> On Tue, Sep 13, 2022 at 02:58:01PM +0200, Pavel Reichl wrote:
> > This is a regression test for an incorrect computation of i_blocks for
> > truncated files larger than 4 GiB. Bug was filed for exFAT.
> > 
> > Test is based on reproducer provied by Christophe Vu-Brugier as part
> > of kernel patch-fix submission.
> > 
> > Signed-off-by: Pavel Reichl <preichl@redhat.com>
> > ---
> >  tests/generic/698     | 48 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/698.out |  2 ++
> >  2 files changed, 50 insertions(+)
> >  create mode 100755 tests/generic/698
> >  create mode 100644 tests/generic/698.out
> > 
> > diff --git a/tests/generic/698 b/tests/generic/698
> > new file mode 100755
> > index 00000000..337df6c5
> > --- /dev/null
> > +++ b/tests/generic/698
> > @@ -0,0 +1,48 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022  Red Hat Inc. All Rights Reserved.
> > +#
> > +# FS QA Test 698
> > +#
> > +# Verify that i_blocks for truncated files larger than 4 GiB have correct
> > +# values.
> > +#
> > +# This test verifies the problem fixed in kernel with commit
> > +# 92fba084b79e exfat: fix i_blocks for files truncated over 4 GiB
> > +#
> > +. ./common/preamble
> > +. ./common/filter
> > +
> > +_begin_fstest auto
> > +
> > +# Override the default cleanup function.
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -r -f $tmp.* $junk_dir
> > +}
> > +
> > +_supported_fs generic
> > +_fixed_by_kernel_commit 92fba084b79e \
> > +	"exfat: fix i_blocks for files truncated over 4 GiB"
> > +
> > +_require_test
> > +_require_fs_space $TEST_DIR $((5 * 1024 * 1024)) #kB
> > +
> > +junk_dir=$TEST_DIR/$seq
> > +junk_file=$junk_dir/junk
> > +mkdir -p $junk_dir
> > +
> > +$XFS_IO_PROG -f -c "pwrite -W 0 5G" $junk_file > /dev/null
> 
> I wonder, how long will this test take to write 5GB of data?  Can we
> speed it up by using fallocate, at least for the filesystems that
> support it?
> 
> (Aside from that, the rest looks fine to me...)

I tried it on one of my testing machine (without high performance), it takes
about 20~30s [1].

The generic/694 is the same with this case. Hi Pavel, If you'd like to speed
it up by detecting and using fallocate, please improve g/694 too. I think we
can have a common helper to get i_blocks for a file, in this helper we can
choose a faster way to do that. For example [PATCH 1/2] brings in this helper
and use it in g/694, then [PATCH 2/2] is this patch.

Thanks,
Zorro


[1]
  # time xfs_io -t -f -c "pwrite 0 5g" /home/file
  wrote 5368709120/5368709120 bytes at offset 0
  5.000 GiB, 1310720 ops; 0:00:23.58 (217.048 MiB/sec and 55564.3920 ops/sec)

  real    0m24.228s
  user    0m0.722s
  sys     0m23.173s

  # time xfs_io -t -f -c "pwrite 0 5g" /home/file
  wrote 5368709120/5368709120 bytes at offset 0
  5.000 GiB, 1310720 ops; 0:00:22.91 (223.438 MiB/sec and 57200.0158 ops/sec)

  real    0m27.538s
  user    0m0.684s
  sys     0m26.313s





> 
> --D
> 
> > +
> > +truncate -s $((4 * 1024 * 1024 * 1024)) $junk_file
> > +
> > +block_size=`stat -c '%B' $junk_file`
> > +iblocks_after_truncate=`stat -c '%b' $junk_file`
> > +iblocks_expected=$((4 * 1024 * 1024 * 1024 / $block_size))
> > +
> > +_within_tolerance "Number of allocated blocks after truncate" $iblocks_after_truncate $iblocks_expected 1% -v
> > +
> > +status=0
> > +
> > +exit
> > diff --git a/tests/generic/698.out b/tests/generic/698.out
> > new file mode 100644
> > index 00000000..cbb02d37
> > --- /dev/null
> > +++ b/tests/generic/698.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 698
> > +Number of allocated blocks after truncate is in range
> > -- 
> > 2.37.3
> > 
> 

