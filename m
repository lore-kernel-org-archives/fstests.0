Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0009CDB482
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Oct 2023 14:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345104AbjJROO6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 Oct 2023 10:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344846AbjJROOQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Oct 2023 10:14:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A48C136
        for <fstests@vger.kernel.org>; Wed, 18 Oct 2023 07:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697638374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZIQUyJepkXTgN+Msx3OG3P1zIbBkFr7LtDDP6GhQH74=;
        b=g+dCdgNKuEfkLcjlkKPOZX9D1pGHgsl3zCcK4Iove9rFHxUKDA/0kRZnd2RtdyugIxHw6P
        xdGRDh+/NKn190hjp3y2ctOsGRdFgYoAmzjqyqT8GY4oHtV9JxumIZwWyrxu2kcsvsph+M
        49+Oh1+3AUND1yPXyS7jfIL4EgJ8RD0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-0qsDkwV7OW2B4jB4nbv3SQ-1; Wed, 18 Oct 2023 10:12:42 -0400
X-MC-Unique: 0qsDkwV7OW2B4jB4nbv3SQ-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-57b6a20d099so8654141eaf.1
        for <fstests@vger.kernel.org>; Wed, 18 Oct 2023 07:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697638361; x=1698243161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIQUyJepkXTgN+Msx3OG3P1zIbBkFr7LtDDP6GhQH74=;
        b=M1Fm5YUFRi9OZxOWSkJ8hg2L4ZnS1X9gHStpJnh6oo8nKeb5EPnfVASvIk2EAy+tPP
         J78w/LwV8ZnGkYsR3F/4FAdQLY6tuidd84SCqlRRG8tRVATErJ72fONuU00a+B5yhKpZ
         bhKfEDf3O1HgdsCZqvARjOxjRVdAqiohvGLhAbt8nN6tp5YD1Q8qi6rMBzDgLsVitsV/
         WiNpnvfqhCAl0PJD9YRE4K6NHqQ6FzVoKfHXnFLpiPTFnjiO7wgczOMovhD/i4XARpAq
         dDRNi2Lr5OE+tDcxbKju4MCbO+AhMqsqd4fdJpGDQLFCX4Jcw06buvLNtALx6vd+0GIY
         SaYQ==
X-Gm-Message-State: AOJu0YwtVNkQkXZK5oe2vatDqwN5pkewV1Z9sls58L/qOgJdnd4mPQU3
        wxFU5qXZcJ8tn+HMsUys5Fg6Kf2aQaKFw4OBo1klc3GdRikm8uQTwaCn50zy01edoaAvKeMTVVV
        OPJNs9zsrK78XW6OzZ/3qCXUyfqTIXcw=
X-Received: by 2002:a05:6359:2c45:b0:139:d5f0:c027 with SMTP id qv5-20020a0563592c4500b00139d5f0c027mr4916261rwb.30.1697638361575;
        Wed, 18 Oct 2023 07:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzGyu49ii/uJIX6w4WESl9TsZrdPyA6lKd2+8+rYw0iLsmqLcLg4E6js3jV2acs4whvAHb5Q==
X-Received: by 2002:a05:6359:2c45:b0:139:d5f0:c027 with SMTP id qv5-20020a0563592c4500b00139d5f0c027mr4916243rwb.30.1697638361257;
        Wed, 18 Oct 2023 07:12:41 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t66-20020a625f45000000b00672ea40b8a9sm3597958pfb.170.2023.10.18.07.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 07:12:40 -0700 (PDT)
Date:   Wed, 18 Oct 2023 22:12:37 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3] generic/707: Test moving directory while being grown
Message-ID: <20231018141237.oorwr6f5vd54vybc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20230131125416.16120-1-jack@suse.cz>
 <20230131142544.dwlk7kwdpznatlt3@zlang-mailbox>
 <20231012140903.tuwphwhp7fh7podq@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012140903.tuwphwhp7fh7podq@quack3>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Oct 12, 2023 at 04:09:03PM +0200, Jan Kara wrote:
> On Tue 31-01-23 22:25:44, Zorro Lang wrote:
> > On Tue, Jan 31, 2023 at 01:54:16PM +0100, Jan Kara wrote:
> > > Test how the filesystem can handle moving a directory to a different
> > > directory (so that parent pointer gets updated) while it is grown. Ext4
> > > and UDF had a bug where if the directory got converted to a different
> > > type due to growth while rename is running, the filesystem got
> > > corrupted.
> > > 
> > > Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > 
> > Thanks, this version looks good to me,
> > 
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> Guys, I have just noticed this patch didn't get merged. Can you please pick
> it up? Thanks!

Hi Jan, I think it has been in fstests v2023.02.05 release, as:

commit da69ce70dfcdbd88d6f940d7c1ab346d5a1e5f82
Author: Jan Kara <jack@suse.cz>
Date:   Tue Jan 31 13:54:16 2023 +0100

    generic/707: Test moving directory while being grown

Isn't it same with this patch? Please check, and feel free to tell me
if anything wrong.

Thanks,
Zorro

> 
> 								Honza
> 
> > 
> > >  tests/generic/707     | 70 +++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/707.out |  2 ++
> > >  2 files changed, 72 insertions(+)
> > >  create mode 100755 tests/generic/707
> > >  create mode 100644 tests/generic/707.out
> > > 
> > > diff --git a/tests/generic/707 b/tests/generic/707
> > > new file mode 100755
> > > index 000000000000..ad1592a1b957
> > > --- /dev/null
> > > +++ b/tests/generic/707
> > > @@ -0,0 +1,70 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2023 Jan Kara, SUSE Linux.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 707
> > > +#
> > > +# This is a test verifying whether the filesystem can gracefully handle
> > > +# modifying of a directory while it is being moved, in particular the cases
> > > +# where directory format changes
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto
> > > +
> > > +_supported_fs generic
> > > +_require_scratch
> > > +
> > > +_fixed_by_kernel_commit f950fd052913 \
> > > +	"udf: Protect rename against modification of moved directory"
> > > +_fixed_by_kernel_commit XXXXXXXXXXXX \
> > > +	"ext4: fix possible corruption when moving a directory"
> > > +
> > > +_scratch_mkfs >>$seqres.full 2>&1
> > > +_scratch_mount
> > > +
> > > +_cleanup()
> > > +{
> > > +	cd /
> > > +	rm -f $tmp.*
> > > +	if [ -n "$BGPID" ]; then
> > > +		# Stop background process
> > > +		kill -9 $BGPID &>/dev/null
> > > +		wait
> > > +	fi
> > > +}
> > > +
> > > +# Loop multiple times trying to hit the race
> > > +loops=$((100*TIME_FACTOR))
> > > +files=500
> > > +moves=500
> > > +
> > > +create_files()
> > > +{
> > > +	# We use slightly longer file name to make directory grow faster and
> > > +	# hopefully convert between various types
> > > +	for (( i = 0; i < $files; i++ )); do
> > > +		touch somewhatlongerfilename$i
> > > +	done
> > > +}
> > > +
> > > +for (( i = 0; i <= $moves; i++ )); do
> > > +	mkdir $SCRATCH_MNT/dir$i
> > > +done
> > > +
> > > +for (( l = 0; l < $loops; l++ )); do
> > > +	mkdir $SCRATCH_MNT/dir0/dir
> > > +	pushd $SCRATCH_MNT/dir0/dir &>/dev/null
> > > +	create_files &
> > > +	BGPID=$!
> > > +	popd &>/dev/null
> > > +	for (( i = 0; i < $moves; i++ )); do
> > > +		mv $SCRATCH_MNT/dir$i/dir $SCRATCH_MNT/dir$((i+1))/dir
> > > +	done
> > > +	wait
> > > +	unset BGPID
> > > +	rm -r $SCRATCH_MNT/dir$moves/dir
> > > +done
> > > +
> > > +echo "Silence is golden"
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/707.out b/tests/generic/707.out
> > > new file mode 100644
> > > index 000000000000..8e57a1d8c971
> > > --- /dev/null
> > > +++ b/tests/generic/707.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 707
> > > +Silence is golden
> > > -- 
> > > 2.35.3
> > > 
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

