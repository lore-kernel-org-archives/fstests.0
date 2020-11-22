Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37B6C63697
	for <linux-fstests@archiver.kernel.org>; Sun, 22 Nov 2020 15:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8421820789
	for <linux-fstests@archiver.kernel.org>; Sun, 22 Nov 2020 15:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2/nck3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgKVPxu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 22 Nov 2020 10:53:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39374 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727745AbgKVPxt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Nov 2020 10:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606060427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YxggdvLZ3Wmjetpl6/VmN4AqR/tTtBrWLP7W2iSue6Q=;
        b=Z2/nck3cJFwQxieWmF8QsZB9+IwwAGQCC4plJotYFMvekl74UBjefr09A12DbOOpogv/G8
        eCZHV18KMme0O/9CWdYrXL3KDXUxoclXqT+jitdYc/d6XSVCNtb5RpbegSg1Iw/u8FBL0M
        TzmUYUlXHr9ZoLXujJrdaunZqT4ZfKk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-jiBaqXfyMGywwkNpOi6jVw-1; Sun, 22 Nov 2020 10:53:45 -0500
X-MC-Unique: jiBaqXfyMGywwkNpOi6jVw-1
Received: by mail-pg1-f197.google.com with SMTP id i6so10708898pgg.10
        for <fstests@vger.kernel.org>; Sun, 22 Nov 2020 07:53:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YxggdvLZ3Wmjetpl6/VmN4AqR/tTtBrWLP7W2iSue6Q=;
        b=d+sW6sM3c+skygsH6qHQFKLWqvu8Um7+bd0Pdilfi1Wk8IW43Bl9N2PASmtj2IhY2d
         xhaF8UT/gwMXiTB0FOAMxIyU3tZJ/Jc7r1Fm5E05t7Xdg7bIvlwU8hV91wzgn4eKpXgC
         rOBWieuXQY/bfygChWyKUr4PEhFxx2eXrxorX/qAp9T/NmBsRuu7m+K8/OArsm6sxK6b
         kycf4JKAqiG/jM1jR0NVySRXwaya9c+SNXiMOLn1XyadS5AxKBTh9FM8CORrtoeB0rCm
         lT9BLIHopdCtlXyJeiK8Zxj8aQqoPgREoBPC37F9DTqkaZhZrQ6FPq/1YNiloH1bVCNG
         AAHg==
X-Gm-Message-State: AOAM531Ajf2pber4Jdj5zc51wTcQ5BelAjeWylXhdkvI7R7wxSDS4g+A
        G+wf3N1tldR1BBMC1Q32ZM9ZFEKAZ0Lh3AnCF1vjVj1Hk9JvGDhPEOEpn1Fo19JKIGBDNUMiNCf
        Hj8qsJ5wrtOr/daPoBw==
X-Received: by 2002:a63:fc5b:: with SMTP id r27mr199106pgk.100.1606060424424;
        Sun, 22 Nov 2020 07:53:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZq9jLmzslgXLEc+50rAbupGMuPCYuRBazovAmlCfGSMarqinbRpUahgK+PEAHFnzCHdJ7Dg==
X-Received: by 2002:a63:fc5b:: with SMTP id r27mr199093pgk.100.1606060424060;
        Sun, 22 Nov 2020 07:53:44 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k73sm8319397pga.88.2020.11.22.07.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 07:53:43 -0800 (PST)
Date:   Sun, 22 Nov 2020 23:53:32 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH] generic: add test for XFS forkoff miscalcution on 32-bit
 platform
Message-ID: <20201122155332.GA2797706@xiangao.remote.csb>
References: <20201118060258.1939824-1-hsiangkao@redhat.com>
 <20201122144633.GM3853@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201122144633.GM3853@desktop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Eryu,

On Sun, Nov 22, 2020 at 10:46:33PM +0800, Eryu Guan wrote:
> On Wed, Nov 18, 2020 at 02:02:58PM +0800, Gao Xiang wrote:

...

> > +# xxxxxxxxxxxx ("xfs: fix forkoff miscalculation related to XFS_LITINO(mp)")
> 
> Would you please re-post when the commit is upstream? With the commit ID
> updated.

Sure will definitely do tomorrow.

> 
> > +
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +. ./common/attr
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +
> > +_supported_fs generic
> > +_require_test
> > +_require_attrs user
> > +
> > +localfile="${TEST_DIR}/testfile"
> 
> Usually we use a testfile prefixed with $seq, e.g.
> 
> localfile=${TEST_DIR}/$seq.testfile
> 
> And remove it before test to avoid side effects from previous runs.
> 
> rm -f $localfile
> touch $localfile

okay, will fix.

Actually I didn't take much time on this (just copy from
generic/611 and use $TEST_DIR instead.) 

> 
> > +
> > +touch "${localfile}"
> > +"${SETFATTR_PROG}" -n user.0 -v "`seq 0 80`" "${localfile}"
> > +"${SETFATTR_PROG}" -n user.1 -v "`seq 0 80`" "${localfile}"
> 
> I'd be better to add comments on why we need two user attrs and why we
> need such long attr value.

There is no specific reason of using "user attrs" and this
combination, just the example in
commit ada49d64fb35 ("xfs: fix forkoff miscalculation related to XFS_LITINO(mp)")

long xattrs which acrosses inline xattr shortform fork can
trigger this issue. As I said in the patch, the bug itself
is xfs-specific, but the testcase is generic.

> 
> > +
> > +# Make sure that changes are written to disk
> > +_test_cycle_mount
> > +
> > +# check getfattr result as well
> 
> Also, better to document the test failure behavior, e.g. kernel crash or
> hung or just a getfattr failure.

It depends, since ASSERT already fails in the second setfattr
and similar as
https://bugzilla.redhat.com/show_bug.cgi?id=1894177

if CONFIG_XFS_ASSERT_FATAL=n, what I saw was that hung on
the _getfattr line. But in any case, _getfattr won't success
with the correct result. So I don't think it needs to document
such unstable status.

Thanks,
Gao Xiang

> 
> Thanks,
> Eryu
> 
> > +_getfattr --absolute-names -ebase64 -d $localfile | tail -n +2 | sort
> > +
> > +status=0
> > +exit
> > diff --git a/tests/generic/618.out b/tests/generic/618.out
> > new file mode 100644
> > index 00000000..848fdc58
> > --- /dev/null
> > +++ b/tests/generic/618.out
> > @@ -0,0 +1,4 @@
> > +QA output created by 618
> > +
> > +user.0=0sMAoxCjIKMwo0CjUKNgo3CjgKOQoxMAoxMQoxMgoxMwoxNAoxNQoxNgoxNwoxOAoxOQoyMAoyMQoyMgoyMwoyNAoyNQoyNgoyNwoyOAoyOQozMAozMQozMgozMwozNAozNQozNgozNwozOAozOQo0MAo0MQo0Mgo0Mwo0NAo0NQo0Ngo0Nwo0OAo0OQo1MAo1MQo1Mgo1Mwo1NAo1NQo1Ngo1Nwo1OAo1OQo2MAo2MQo2Mgo2Mwo2NAo2NQo2Ngo2Nwo2OAo2OQo3MAo3MQo3Mgo3Mwo3NAo3NQo3Ngo3Nwo3OAo3OQo4MA==
> > +user.1=0sMAoxCjIKMwo0CjUKNgo3CjgKOQoxMAoxMQoxMgoxMwoxNAoxNQoxNgoxNwoxOAoxOQoyMAoyMQoyMgoyMwoyNAoyNQoyNgoyNwoyOAoyOQozMAozMQozMgozMwozNAozNQozNgozNwozOAozOQo0MAo0MQo0Mgo0Mwo0NAo0NQo0Ngo0Nwo0OAo0OQo1MAo1MQo1Mgo1Mwo1NAo1NQo1Ngo1Nwo1OAo1OQo2MAo2MQo2Mgo2Mwo2NAo2NQo2Ngo2Nwo2OAo2OQo3MAo3MQo3Mgo3Mwo3NAo3NQo3Ngo3Nwo3OAo3OQo4MA==
> > diff --git a/tests/generic/group b/tests/generic/group
> > index 94e860b8..eca9d619 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -620,3 +620,4 @@
> >  615 auto rw
> >  616 auto rw io_uring stress
> >  617 auto rw io_uring stress
> > +618 auto quick attr
> > -- 
> > 2.18.4
> 

