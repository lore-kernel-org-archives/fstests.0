Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5C1C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 18 May 2022 02:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiERCX3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 May 2022 22:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbiERCX2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 May 2022 22:23:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB4714F9ED
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 19:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652840606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OmBws4NLJoG/76PWdOZJM1qJZnsedQA+qlvnqmIwGfk=;
        b=d9qWoylseZHBfrXZrNiJYylsDOsDtKn9sQg6S16/Z2rW4LmUQhI6FuiVeNxgMjslgkig04
        E01KGj4GB5S/9KEKWp1c+6hTQ2rktWgvReU9rNrVACFcS0oByYSX7S6yplLGzTV5UFdhC8
        L6RpPyYe+/Qe+rsDLSm6cleYIrNBqTI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-wuLeBI6jNd2AIwf_pR-nQg-1; Tue, 17 May 2022 22:23:24 -0400
X-MC-Unique: wuLeBI6jNd2AIwf_pR-nQg-1
Received: by mail-qt1-f200.google.com with SMTP id q13-20020a05622a04cd00b002f3c0e197afso765039qtx.0
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 19:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=OmBws4NLJoG/76PWdOZJM1qJZnsedQA+qlvnqmIwGfk=;
        b=UPe8DwZnS8nxo3jOq5VA+jjov88MJZB66RLTzlYk0u8s+3t1hefW47ifccuwcK3H4T
         cjWxtREgfnbSJfJqPst98URQx+2i9HbRpyvoH29gVq03DsSQiV+IM5Iu7E2jodxY5T2K
         KSnbI9otF9zYaMzK4S4f3fGXTgVoKNtmGM0Pb5tTuqg6xDrxLjbRUezNjN7yp4Cb/VwP
         YCTjvCCpOrFbpmUClA368Ojx0zxWcwNkoAQHWwlSEytv04IgOzqOa03Q0orkm1OtZTqw
         P7sc7thbNv7yp31H8FicTQ81WGWNmae9sgRmeSe37Q0xXA32JC+NDGDJRkh93nNvt1yj
         yxYQ==
X-Gm-Message-State: AOAM533208w5H/Bd5O9PfRPDFnmjf76arwW5c0Eoco+ajgttFlcdghaq
        Pm7YcBJlEHaaF8yqYC5B+577bhNeFgrjFX0BB8VcE5TU0H5y8L0OHGlVgurcij9SnIxXPdxyCyP
        DiyBnubGAqCMOP8Hxbw==
X-Received: by 2002:ac8:5713:0:b0:2f3:d872:2fa8 with SMTP id 19-20020ac85713000000b002f3d8722fa8mr21864018qtw.49.1652840603606;
        Tue, 17 May 2022 19:23:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGO5zU9l6j21IUcs2K8ZARQy8DTUlv/Uq6ETt10EBM+Yd6vZix7cqfNR88LpUWDiNH84oWYQ==
X-Received: by 2002:ac8:5713:0:b0:2f3:d872:2fa8 with SMTP id 19-20020ac85713000000b002f3d8722fa8mr21864004qtw.49.1652840603109;
        Tue, 17 May 2022 19:23:23 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d28-20020ac8615c000000b002f7de524d8dsm424185qtm.79.2022.05.17.19.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 19:23:22 -0700 (PDT)
Date:   Wed, 18 May 2022 10:23:17 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/4] fstests: fix group list generation for whacky test
 names
Message-ID: <20220518022317.fuim4y5e2mhgpj6f@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
References: <20220516085922.1306879-1-david@fromorbit.com>
 <20220516085922.1306879-2-david@fromorbit.com>
 <YoJ5yvYD9ZmNoNVi@magnolia>
 <20220516213516.GL2306852@dread.disaster.area>
 <YoLPfAi8sZH99FuV@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoLPfAi8sZH99FuV@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 16, 2022 at 03:26:04PM -0700, Darrick J. Wong wrote:
> On Tue, May 17, 2022 at 07:35:17AM +1000, Dave Chinner wrote:
> > On Mon, May 16, 2022 at 09:20:26AM -0700, Darrick J. Wong wrote:
> > > On Mon, May 16, 2022 at 06:59:19PM +1000, Dave Chinner wrote:
> > > > From: Dave Chinner <dchinner@redhat.com>
> > > > 
> > > > Darrick noticed that tests/xfs/191-input-validation didn't get
> > > > generated properly. Fix the regex to handle this.
> > > > 
> > > > $ grep -I -R "^_begin_fstest" tests/xfs | \
> > > >   sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' |grep 191
> > > > tests/xfs/191-input-validation:_begin_fstest auto quick mkfs realtime
> > > > $
> > > > $ grep -I -R "^_begin_fstest" tests/xfs | \
> > > >   sed -e 's/^.*\/\([0-9]*\).*:_begin_fstest/\1/ ' |grep 191
> > > > 191 auto quick mkfs realtime
> > > > $
> > > > 
> > > > Long term, we should rename that test to '191' and rip out all that
> > > > unused and unnecessary complexity for matching ascii test names
> > > > because we just don't use it. Numbers for tests are still working
> > > > just fine.
> > > > 
> > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > ---
> > > >  tools/mkgroupfile | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/mkgroupfile b/tools/mkgroupfile
> > > > index 24435898..958d4e2f 100755
> > > > --- a/tools/mkgroupfile
> > > > +++ b/tools/mkgroupfile
> > > > @@ -60,7 +60,7 @@ ENDL
> > > >  
> > > >  	# Aggregate the groups each test belongs to for the group file
> > > >  	grep -I -R "^_begin_fstest" $test_dir/ | \
> > > > -		sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' >> $new_groups
> > > > +		sed -e 's/^.*\/\([0-9]*\).*:_begin_fstest/\1/' >> $new_groups
> > > 
> > > Sorry I didn't get a chance to review this patch before it went in, but

Sorry, I'll try to leave more time to you next time, if a patch touches the code
related with you.

> > > this string parsing gets tripped up by things that the old code handled
> > > just fine.  Back when we'd run _begin_fstest as a real bash subroutine
> > > to print the group name arguments, a line like this:
> > > 
> > > _begin_fstest deprecated # log logprint quota
> > 
> > And I just don't care about that.
> 
> I *do*, because my entire testing dashboard turned red overnight because
> these changes broke the group list file generation and pulled in tests
> that normally get excluded from my nightly test runs.

Sorry Darrick, my general regression test[1] didn't cover your usage, cause
I didn't hit this "broken" error... Actually after talking with you last week,
I'm planning to change the ways I use fstests, especially for those groups
not belong to "auto". That might help to find issues like this in time.

Furthermore, I don't know why no one found this regression either in the past
one week after for-next branch been updated. I'm thinking about extend the
interval between for-next with master update, change from 1 week to 2 weeks.
As 1 week "soak period" looks like a little short.

Feel free to ping me, if you have more suggestions.

Thanks,
Zorro

[1]
./check -g auto
./check -g all -x auto

> 
> Did _anyone_ actually compare the group.list output before and after
> applying the patch?
> 
> $ diff -U 1 -r build-old/tests/ build-x86_64/tests/
> diff -U 1 -r build-old/tests/xfs/group.list
> build-x86_64/tests/xfs/group.list
> --- build-old/tests/xfs/group.list      2022-05-16 15:05:55.655374923 -0700
> +++ build-x86_64/tests/xfs/group.list   2022-05-16 15:07:12.562086066 -0700
> @@ -3,2 +3,3 @@
>  
> +/home/djwong/cdev/work/fstests/build-x86_64/tests/xfs/191-input-validation:_begin_fstest
> auto quick mkfs realtime broken
>  001 db auto quick
> @@ -20,3 +21,3 @@
>  017 mount auto quick stress
> -018 deprecated
> +018 deprecated # log logprint v2log
>  019 mkfs auto quick
> @@ -83,4 +84,4 @@
>  080 rw ioctl
> -081 deprecated
> -082 deprecated
> +081 deprecated # log logprint quota
> +082 deprecated # log logprint v2log
>  083 dangerous_fuzzers punch
> @@ -191,3 +192,2 @@
>  190 rw auto quick
> -191-input-validation auto quick mkfs realtime broken
>  192 auto quick clone
> 
> 
> > Handling these whacky corner cases is the *wrong solution* - we're
> > just creating more technical debt for ourselves going down that
> > path.
> 
> Frankly, I think this whole change *introduces* technical debt.
> 
> Test files used to be bash scripts that have /all/ the standard
> behaviors of bash scripts -- commands can have comments at the end of
> the line, continuations are supported, etc.  Test authors merely have to
> ensure that the script parses correctly, and that the groups for each
> test are specified as options to _begin_fstest.
> 
> Now you've effectively made it so that there's this one weird line that
> looks like any other piece of shell script, but it isn't.  You can't
> have comments, you can't use line continuations, and if you
> accidentally drop something like a colon in the line, there's a risk
> that a regular expression will do the wrong thing and explode.
> 
> In other words, test scripts aren't purely bash scripts anymore even
> though they sure look like pure bash.  Every author must now be aware
> that there's a behavioral quirk pertaining to exactly one required line
> in every test script.
> 
> > $ git grep _begin_fstest tests/ |grep "#"
> > tests/xfs/018:_begin_fstest deprecated # log logprint v2log
> > tests/xfs/081:_begin_fstest deprecated # log logprint quota
> > tests/xfs/082:_begin_fstest deprecated # log logprint v2log
> > $
> > 
> > There are the only 3 tests marked deprecated. *Nobody runs them* and
> > if they did, they all fail on a current kernel:
> > 
> > ....
> > Running: MOUNT_OPTIONS= ./check -R xunit -b -s xfs xfs/018 xfs/081 xfs/082
> > ....
> > Failures: xfs/018 xfs/081 xfs/082
> > Failed 3 of 3 tests
> > 
> > We don't need to support this whacky corner case - just remove
> > the three deprecated tests completely. If anyone needs them, they
> > are still in the git history. But the right thing to do is to remove
> > the corner case altogether, not add complexity to handle it
> > needlessly.
> 
> Then why didn't you propose remove them?  I agree that these three are
> hopelessly broken and I've never gotten x/191 to pass, and fully support
> removing them.
> 
> > > Instead, that above output (which I harvested from xfs/081) now
> > > becomes:
> > > 
> > > 081 deprecated # log logprint quota
> > > 
> > > The first grepsed blobule should do more if it's going to
> > > performance-optimize bash:
> > 
> > We don't need to "performance-optimize bash" - we've already fixed
> > the problem by addressing the low hanging fruit (35s down to less
> > than 0.4s, and less than 0.1s with make -j8).
> 
> That's nice that it's faster to build, but IMHO it's *broken*.  The
> original patch was a performance improvement that submarined in a change
> in how we have to write tests.
> 
> The comments for _begin_fstest don't make any mention at all of the new
> requirements for the _begin_fstest callsite.
> 
> > Beyond where we iare now is really "don't care" territory because
> > nobody is going to notice it going 0.1s faster now. OTOH, we are sure
> > as anything going to notice the complexity of the regexes in a
> > year's time when we have to work out what it does from first
> > principles again....
> 
> I already had to do that, and it's barely been 10 days since this was
> committed.
> 
> > > grep -I -R "^_begin_fstest" -Z $test_dir/ | \
> > > 	sed -e 's/#.*$//g' \
> > 
> > This is the only bit that is needed to handle the commented out
> > group case, everythign else is just complexity that comes from
> > over-optimisation. And even handling comments is largely unnecessary
> > because removing deprecated tests is the right way to fix this...
> 
> ...until the next person trips over this.
> 
> --D
> 
> > Cheers,
> > 
> > Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
> 

