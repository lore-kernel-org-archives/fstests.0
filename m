Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B41C43334
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Jun 2022 04:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244172AbiF1Eco (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jun 2022 00:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244135AbiF1Ecn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jun 2022 00:32:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 868041C10F
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 21:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656390758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJrpicm06aJMU8IgkPl4F0r+SkpCimIJfvh4jXNOXZ4=;
        b=FtGbp6EaOH7zvq76LiJ0hpw4ae3IjCKWG2/teyL8AtHzjxhjyLYHkX8vuAzvJuDaozIB8J
        qhyT4nMK8QGy6SrsqZaQQHOFxflU/k2Ueaa6wlKozy6/KcZkoyS7K0cuFbhMFru0ZWsDRM
        qAMYDFbc2ZTqip6p3kYDurFpW8jCOIw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-efUpm6sTM3-oZN2b1Rd07A-1; Tue, 28 Jun 2022 00:32:36 -0400
X-MC-Unique: efUpm6sTM3-oZN2b1Rd07A-1
Received: by mail-qk1-f199.google.com with SMTP id a7-20020a37b107000000b006af3bc02282so3375416qkf.21
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 21:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WJrpicm06aJMU8IgkPl4F0r+SkpCimIJfvh4jXNOXZ4=;
        b=WKmrBxIU6cz0MN8kjNRU9E+D3MVfQLqVrldGm/WSbF9tW23QWx/qILj5dVEC/mC2iq
         opQYrhXpE4ub6OookyW3MIBg9HllOCoD+l1uBmPQ6wUZIE4KQBRdAuTPuZQkSHq7TZYj
         6Hk9JHhmcQv6VxEBKSusy1lSxSEGrQD/s+4HtNRoh1EiSOTtJOnem3D24dGBc8zs2O2L
         VHmtFtegEDSOJEgmVGs7kUxw03/W0D47noBZjDv+WMccVF8qDg1UZk1sgBc9e8qwx5Fq
         /hMiwL1CBPGpfJe4gq2wQHYa6kcEYwOOjDk40/QMGmskMiJFk2LHj57lY+yUzbYfwToC
         DUBg==
X-Gm-Message-State: AJIora80REJgZ76MzUB0zxKJEnfj9djt2UACCbe8j6DBDUBRqS5GNrTH
        bsJbMT0MTak9u1xnjHXgMVQ4HNpA9wK8LTyXDnFAJschQxqZEnM7Bf7jBp4C8UAJDnwHIOpOsXf
        YM7iysBkzFKIGwsX2QQ==
X-Received: by 2002:ad4:4ee4:0:b0:472:7778:ff86 with SMTP id dv4-20020ad44ee4000000b004727778ff86mr2187036qvb.109.1656390755534;
        Mon, 27 Jun 2022 21:32:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vsJbxW+6mzXJWvHXnRV2Y0aMzNTsyJpJ37zJgyCCcbwm87Z8K6II9XoCPRnNa1bpD52gEKYw==
X-Received: by 2002:ad4:4ee4:0:b0:472:7778:ff86 with SMTP id dv4-20020ad44ee4000000b004727778ff86mr2187025qvb.109.1656390755276;
        Mon, 27 Jun 2022 21:32:35 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ey14-20020a05622a4c0e00b002fcb0d95f65sm8259677qtb.90.2022.06.27.21.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 21:32:34 -0700 (PDT)
Date:   Tue, 28 Jun 2022 12:32:29 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/5] ext4/044: skip test if the file system does not have
 a journal
Message-ID: <20220628043229.pkluyozx4rfqqkfc@zlang-mailbox>
References: <20220625030718.1215980-1-tytso@mit.edu>
 <20220625030718.1215980-3-tytso@mit.edu>
 <20220628042817.2xxzleisfguoq7qh@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628042817.2xxzleisfguoq7qh@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 28, 2022 at 12:28:17PM +0800, Zorro Lang wrote:
> On Fri, Jun 24, 2022 at 11:07:15PM -0400, Theodore Ts'o wrote:
> > This test mounts the file system using "mount -t ext3"; if the file
> > system config creates the file system without the jbd2 journal, the
> > "mount -t ext3" will fail.  So skip this test in that case.
> > 
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > ---
> >  tests/ext4/044 | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/tests/ext4/044 b/tests/ext4/044
> > index 46e44053..fd27ae2d 100755
> > --- a/tests/ext4/044
> > +++ b/tests/ext4/044
> > @@ -16,11 +16,17 @@ _begin_fstest auto quick
> >  _supported_fs ext4
> >  _require_scratch
> >  _require_test_program "t_get_file_time"
> > +_require_dumpe2fs
> >  
> >  echo "Silence is golden"
> >  
> >  echo "Test timestamps with 256 inode size one device $SCRATCH_DEV" >$seqres.full
> >  _scratch_mkfs -t ext3 -I 256 >> $seqres.full 2>&1
> > +
> > +$DUMPE2FS_PROG -h $SCRATCH_DEV 2>> $seqres.full | grep '^Filesystem features' | grep -q has_journal
> > +if [ $? -ne 0 ]; then
> > +    _notrun "ext4 file system formatted without a journal"
> > +fi
> 
> Can _has_metadata_journaling help that?

Or use _require_metadata_journaling directly?

> 
> Thanks,
> Zorro
> 
> >  _scratch_mount
> >  
> >  # Create file
> > -- 
> > 2.31.0
> > 

