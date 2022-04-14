Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC20AC433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 14 Apr 2022 19:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbiDNTNP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 14 Apr 2022 15:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345224AbiDNTMx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Apr 2022 15:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20815E996A
        for <fstests@vger.kernel.org>; Thu, 14 Apr 2022 12:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649963426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oXN14qVohsTdrb1Av33RmOL9WFAZxdwdKyG1omWjlZM=;
        b=SrXezc393chOs6qJGvIpbuZwcUQG5ZPO5f8UglXZ4gmQ75pjBkWOxYNjMjRZG9rqAL/zyP
        g1MU4pNh30wNjXh36Z7bjWx+fTV0kbcLSXpCCMTRp6JpHvgKIqUadVOXhXfLTJi9x2ytjb
        o/OjHXvn/8IB+Cmw8q8Y8qavXNSu7O4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-HaE_FRxiPAGvJ8XcVAWBPw-1; Thu, 14 Apr 2022 15:10:24 -0400
X-MC-Unique: HaE_FRxiPAGvJ8XcVAWBPw-1
Received: by mail-qv1-f72.google.com with SMTP id z12-20020a0ce60c000000b0044632eb79b3so723359qvm.7
        for <fstests@vger.kernel.org>; Thu, 14 Apr 2022 12:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=oXN14qVohsTdrb1Av33RmOL9WFAZxdwdKyG1omWjlZM=;
        b=7F9QrlLdNfsG0Hd7VBfPezI6lh9pgs33EVl4cro/ZTV1F9+0QnE+iUZz6rXsRPPd2l
         Kj82HK2cUfsbAbNN1giplVyeVWWb2MlUfz6aaaMU2BYB9QXcw7388uuckL6fz8QYZ7tu
         a8LWOCxyeLZ+Uly1xuzpjmSh7PJx+iVJ5fGhwyJeApIaPwueiu9cMBslJrAsYwrSudfV
         M3u2yZzMqG9npCRFJPS0aarVsH9woviDv/0zgcQrSzW0lZAVbhOEokcB2je/OJVA998X
         UynkY4aYZmkfdYzIbs8lzqRYA7dTfDoUAgH/5npc8jcGeGxzRxJ81YIpC8oqrro1AedX
         hWsg==
X-Gm-Message-State: AOAM531rAIsOe/TDpuYmmFu7T0wwb8gtbNNJXocVBIzcgd28t509BBsi
        Qofn2tEx/zOVdggTsiD1MpuNfgN9ulc4ms0QGN5diYu3FF4Kko3ENYo6eDXuYf4FRoADbxUSei5
        3LTDMiU4CGIMxHwnKEQ==
X-Received: by 2002:a05:6214:4006:b0:432:ea2b:5aad with SMTP id kd6-20020a056214400600b00432ea2b5aadmr4793100qvb.39.1649963424421;
        Thu, 14 Apr 2022 12:10:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzipImHRyR1skxzi2t7NMIeVG9eXIDIS5MdlYRi4+r188rwyjbgm2xa101X7dH+KXJQHFTC9A==
X-Received: by 2002:a05:6214:4006:b0:432:ea2b:5aad with SMTP id kd6-20020a056214400600b00432ea2b5aadmr4793071qvb.39.1649963424078;
        Thu, 14 Apr 2022 12:10:24 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f11-20020a05620a20cb00b0069c0d58fdaesm1271881qka.98.2022.04.14.12.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 12:10:23 -0700 (PDT)
Date:   Fri, 15 Apr 2022 03:10:17 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>, Eryu Guan <guan@eryu.me>
Subject: Re: [PATCH 2/4] generic: ensure we drop suid after fallocate
Message-ID: <20220414191017.jmv7jmwwhfy2n75z@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>, Eryu Guan <guan@eryu.me>
References: <164971767143.169983.12905331894414458027.stgit@magnolia>
 <164971768254.169983.13280225265874038241.stgit@magnolia>
 <20220412115205.d6jjudlkxs72vezd@zlang-mailbox>
 <CAOQ4uxiDW6=qgWtH8uHkOmAyZBR7vfgwgt-DA_Rn0QVihQZQLw@mail.gmail.com>
 <20220413154401.vun2usvgwlfers2r@zlang-mailbox>
 <20220414155007.GC17014@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414155007.GC17014@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 14, 2022 at 08:50:07AM -0700, Darrick J. Wong wrote:
> On Wed, Apr 13, 2022 at 11:44:01PM +0800, Zorro Lang wrote:
> > On Wed, Apr 13, 2022 at 10:58:41AM +0300, Amir Goldstein wrote:
> > > On Wed, Apr 13, 2022 at 1:18 AM Zorro Lang <zlang@redhat.com> wrote:
> > > >
> > > > On Mon, Apr 11, 2022 at 03:54:42PM -0700, Darrick J. Wong wrote:
> > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > >
> > > > > fallocate changes file contents, so make sure that we drop privileges
> > > > > and file capabilities after each fallocate operation.
> > > > >
> > > > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > > > ---
> > > > >  tests/generic/834     |  127 +++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  tests/generic/834.out |   33 +++++++++++++
> > > > >  tests/generic/835     |  127 +++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  tests/generic/835.out |   33 +++++++++++++
> > > > >  tests/generic/836     |  127 +++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  tests/generic/836.out |   33 +++++++++++++
> > > > >  tests/generic/837     |  127 +++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  tests/generic/837.out |   33 +++++++++++++
> > > > >  tests/generic/838     |  127 +++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  tests/generic/838.out |   33 +++++++++++++
> > > > >  tests/generic/839     |   77 ++++++++++++++++++++++++++++++
> > > > >  tests/generic/839.out |   13 +++++
> > > > >  12 files changed, 890 insertions(+)
> > > > >  create mode 100755 tests/generic/834
> > > > >  create mode 100644 tests/generic/834.out
> > > > >  create mode 100755 tests/generic/835
> > > > >  create mode 100644 tests/generic/835.out
> > > > >  create mode 100755 tests/generic/836
> > > > >  create mode 100644 tests/generic/836.out
> > > > >  create mode 100755 tests/generic/837
> > > > >  create mode 100644 tests/generic/837.out
> > > > >  create mode 100755 tests/generic/838
> > > > >  create mode 100644 tests/generic/838.out
> > > > >  create mode 100755 tests/generic/839
> > > > >  create mode 100755 tests/generic/839.out
> > > > >
> > > > >
> > > > > diff --git a/tests/generic/834 b/tests/generic/834
> > > > > new file mode 100755
> > > > > index 00000000..9302137b
> > > > > --- /dev/null
> > > > > +++ b/tests/generic/834
> > > > > @@ -0,0 +1,127 @@
> > > > > +#! /bin/bash
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> > > > > +#
> > > > > +# FS QA Test No. 834
> > > > > +#
> > > > > +# Functional test for dropping suid and sgid bits as part of a fallocate.
> > > > > +#
> > > > > +. ./common/preamble
> > > > > +_begin_fstest auto clone quick
> > > > > +
> > > > > +# Override the default cleanup function.
> > > > > +_cleanup()
> > > > > +{
> > > > > +     cd /
> > > > > +     rm -r -f $tmp.* $junk_dir
> > > > > +}
> > > > > +
> > > > > +# Import common functions.
> > > > > +. ./common/filter
> > > > > +. ./common/reflink
> > > > > +
> > > > > +# real QA test starts here
> > > > > +
> > > > > +# Modify as appropriate.
> > > > > +_supported_fs xfs btrfs ext4
> > > >
> > > > So we have more cases will break downstream XFS testing :)
> > > 
> > > Funny you should mention that.
> > > I was going to propose an RFC for something like:
> > > 
> > > _fixed_by_kernel_commit fbe7e5200365 "xfs: fallocate() should call
> > > file_modified()"
> > > 
> > > The first thing that could be done with this standard annotation is print a
> > > hint on failure, like LTP does:
> > > 
> > > HINT: You _MAY_ be missing kernel fixes:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fbe7e5200365
> > 
> > I think it's not difficult to implement this behavior in xfstests. Generally if
> > a case covers a known bug, we record the patch commit in case description.
> 
> It's not hard, but it's a treewide change to identify all the fstests
> that are regression fixes (or at least mention a commit hash) and well
> beyond the scope of adding tests for a new fallocate security behavior.
> 
> In fact, it's an *entirely new project*.  One that I don't have time to
> take on myself as a condition for getting *this* patch merged.

Hi Darrick, that's another story, you don't need to worry about that in this case :)
I'd like to ack this patch, but hope to move it from generic/ to shared/ . Maybe
Eryu can help to move it, or I can do that after I get the push permission.

The reason why I intend moving it to shared is:
Although we are trying to get rid of tests/shared/, but the tests/shared/ still help to
remind us what cases are still not real generic cases. We'll try to help all shared
cases to be generic. When the time is ready, I'd like to move this case to generic/
and change _supported_fs from "xfs btrfs ext4" to "generic".

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

