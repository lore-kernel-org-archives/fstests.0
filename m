Return-Path: <SRS0=o+XN=BB=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AEEC433E2
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jul 2020 03:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C6F207CD
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jul 2020 03:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd/o0nRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbgGVDLk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 21 Jul 2020 23:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731614AbgGVDLj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Jul 2020 23:11:39 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C229DC061794
        for <fstests@vger.kernel.org>; Tue, 21 Jul 2020 20:11:39 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o1so274169plk.1
        for <fstests@vger.kernel.org>; Tue, 21 Jul 2020 20:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B5M4dhSQkGvqVYUHluzSIHjBozMLZibN1+U777KAzsY=;
        b=Xd/o0nRukHkn6BPxnfIjma/cl7aoGpzxnUVfmDfPOq+CCrEgJZ+NhrA4A+UNlmCFQ9
         m20tpp0iIrCO9b1szM2EAeLXsMPV4TL/+E57siQT7BfWJgO8JOAaoBw/HL7RxOnFleo3
         8M2wCMzQKF3NLO3E8oBma2ymINRDjR9dgtidy28P3WvLbbaFKbWZ9dhVKhgzkxpD6WKi
         H8cu0nzpAGENZS1qdDOVXcXD0of/FEBu9/CAXb4kpGPGOFB7jvA7rkNG9CXW7jtM0qfK
         4S0Cmn2mtMbDCfM3FBdNv9evLeK5flMz8Z3636jh5r+cGnMI2GZoo2rv2+Z4dcWqwyqI
         Rpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B5M4dhSQkGvqVYUHluzSIHjBozMLZibN1+U777KAzsY=;
        b=KvmITyzna0+7U/XwriEmPJPdZlwCcv+0rtdf8CjLbIQwWYFVbAu2rnkzN+JYTyAO9U
         USSwWtVxGQdVfDwPjCvGG8QIB8+ayaYosl8mfnf9x9Lcfl3/dwQlSvwUbc9ZJBCXKAI3
         59ZJQvj6c5Z1bPJabZOa/PeochSBIUiVkjuKUsxQ/DoJvndLA6qMIIJrAfLykda+5+rw
         OZ1KFyhleLplDNa7T4tGf644aI7MxTehT8TdlJG8HLicnwg9MwrIs3afN/sdQ9CQNGmx
         4YqiXFRlvkv9Lc9KGSXm+mDUKLo8cepKwnakDcZ2qWLT+fAxDW/IXTWp4fUYtUyglKeD
         cRLw==
X-Gm-Message-State: AOAM533/+trBrTHrpDPmoVDZ/y4nMqdrKV47mT5XeKQGVRHX0K/EZLSe
        Cx6QOlagkevU8cYhJt3Yeta79H+g/D8=
X-Google-Smtp-Source: ABdhPJzBu7NI2rDENbejUi9bWRKcz3+uDXHJuE+2dIM6GIc3JkiV1J7xK/fPA0/bzfOPdkJ9d2LVTg==
X-Received: by 2002:a17:902:9b97:: with SMTP id y23mr25825212plp.189.1595387499300;
        Tue, 21 Jul 2020 20:11:39 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v11sm22994952pfc.108.2020.07.21.20.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 20:11:38 -0700 (PDT)
Date:   Wed, 22 Jul 2020 11:11:31 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/175, generic/176: cleanup testdir before exit
Message-ID: <20200722031131.amr6qntxtihjcuzt@xzhoux.usersys.redhat.com>
References: <20200717044017.1598-1-jencce.kernel@gmail.com>
 <20200717055853.GB1938@dhcp-12-102.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717055853.GB1938@dhcp-12-102.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jul 17, 2020 at 01:58:53PM +0800, Zorro Lang wrote:
> On Fri, Jul 17, 2020 at 12:40:17PM +0800, Murphy Zhou wrote:
> > Usually the _mkfs helper will cleanup these directories at the
> > beginning of testcase. However, when testing on NFS, the cleanup
> > could be very slow and it is confusing that: We have already
> 
> The _scratch_mkfs logic for NFS is:
>   [ -n "$SCRATCH_MNT" ] || return 1
>   _scratch_mount
>   rm -rf $SCRATCH_MNT/*
>   _scratch_unmount
> 
> If you feel NFS is 'very slow', and isn't normal, you can check how
> NFS is dealing with the reflink file of g/175.
> 
> > started to run generic/176 but we get stuck in _mkfs, cleaning
> > up files left by the previous testcase generic/175.
> 
> Hmm... that makes more sense than above reason, although we generally
> don't cleanup SCRATCH_MNT/* at the end of a case. Due to if you need to
> cleanup SCRATCH_MNT/* for NFS, why only these 2 cases need to do that?
> We might need a better reason/comment to explain, e.g. it cover a issue
> of NFS?
> 
> BTW, the cleanup operation can be in _cleanup() function, likes:
>   [ -d "$testdir" ] && rm -rf $testdir
> 
> Thanks,
> Zorro
> 
> > 
> > To be clear, cleanup testdir before exit. Also, deleting files
> > should be part of the stress test.

These 2 lines are the real reasons for adding this.

Thanks!

> > 
> > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > ---
> >  tests/generic/175 | 1 +
> >  tests/generic/176 | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/tests/generic/175 b/tests/generic/175
> > index 79e5b3d6..bd966a28 100755
> > --- a/tests/generic/175
> > +++ b/tests/generic/175
> > @@ -61,6 +61,7 @@ bytes=$((blks * blksz))
> >  echo "reflinking $blks blocks, $bytes bytes" >> "$seqres.full"
> >  _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
> >  
> > +rm -rf $testdir
> >  # success, all done
> >  status=0
> >  exit
> > diff --git a/tests/generic/176 b/tests/generic/176
> > index a084578a..bc83762e 100755
> > --- a/tests/generic/176
> > +++ b/tests/generic/176
> > @@ -73,6 +73,7 @@ bytes=$((blocks_needed * blksz))
> >  echo "reflinking $((blocks_needed / 2)) blocks, $((bytes / 2)) bytes" >> "$seqres.full"
> >  _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
> >  
> > +rm -rf $testdir
> >  # success, all done
> >  status=0
> >  exit
> > -- 
> > 2.20.1
> > 
> 

-- 
Murphy
