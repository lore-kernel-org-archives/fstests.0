Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3480EC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 09:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbiEXJ7t (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 05:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbiEXJ7s (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 05:59:48 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DC87628D
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 02:59:47 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id v11so14694787qkf.1
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 02:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cGI4562Mg6osYZZZNrzE+t7jQFXO1RG7gUiSyNgtbNo=;
        b=borbUF0j9hilzesOEypyFQnb3VddtrIl+nFbklyfQ13KfUl9ZNRyCpDUZa25bwFobW
         yrx/IxCRD84ss2hPSE6GGQmqQO1Cboq5f8nbwlNZHDLijqn6Do52erm3jDxhVmr2dEry
         e8riq6MOzh21gei1iGeR+JvEGF4acEKtlFERs3W2jgZVzyFVAlZW+g1PXKslVFpZQvnC
         GwWyGLnhRrirPemhEY8mkHSUDTlZggqmlUPpYSLT4nGfOk2Q1+Vn+FjrsI+uBYYeKvts
         LQxK5rfoopiVmUwOraQO6DWZTuklT9j/9VbpZUclsJEdVEx5/oH764q3LLg3lXv5w4Sn
         mZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cGI4562Mg6osYZZZNrzE+t7jQFXO1RG7gUiSyNgtbNo=;
        b=G5vhBVVvlMH7idnT4VBduR5hKtRbK/dGu/4O/lnUVQvmhARMs/HxMFbPDaX/DSdiLp
         LMPJpkcrsWiBKtBj3A4LFzL6V4y2tDn7rsZgVEOtgfymggs9FbAaiN0E9Ey6ClRd5N6b
         xuhfZ+H4PdscQ3gXUHQbIadvpQFqV1M8VJG0VEeU6m77LFaxVPH6tKSXjkARatA/4FVc
         q8UPXb1IEerni49UFt8G0yn5AATuITTAu0iUz1Ngxe5SxGZLEI8QL07Y9eZNnk96csES
         nhb+akj4RnjSkHufNXq0c0KC8Lo2pD11TXogI71U/Lyxlxs99mcGlGk3S17YIJCkEO3i
         /cAg==
X-Gm-Message-State: AOAM532SMzXDgDhYdH3R+q3ohaypA3VqfCgWNFBeOfjwfIH2vNLTPpNT
        7giTC4C80KWStL8cAlxoXvR6xVV8O0Sm2cakxfGD1CuH7RU=
X-Google-Smtp-Source: ABdhPJzu6QbtudmMu4lZFd6iZBL6hgR8YEVKsjne8L9vfLzbqHkjNIVREo+EKvGD3VB2uW9ethKQgjKLInn7MugL77Q=
X-Received: by 2002:a37:6cc2:0:b0:6a3:769c:e5ba with SMTP id
 h185-20020a376cc2000000b006a3769ce5bamr7079914qkc.19.1653386387083; Tue, 24
 May 2022 02:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220524073411.1943480-1-david@fromorbit.com> <20220524073411.1943480-5-david@fromorbit.com>
 <CAOQ4uxiKbdMQZsr335RM6Og6XLkSTUdVw7NdsYD3djJbtPGRmQ@mail.gmail.com> <20220524095244.GG2306852@dread.disaster.area>
In-Reply-To: <20220524095244.GG2306852@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 May 2022 12:59:35 +0300
Message-ID: <CAOQ4uxgjBzcH5uw9KMYk9dcv22d1us7-DqXiyN2f-xTX=GJfhg@mail.gmail.com>
Subject: Re: [PATCH 4/8] fstests: define a common _dump_cleanup function
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 12:52 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, May 24, 2022 at 12:04:36PM +0300, Amir Goldstein wrote:
> > On Tue, May 24, 2022 at 11:32 AM Dave Chinner <david@fromorbit.com> wrote:
> > > diff --git a/tests/xfs/026 b/tests/xfs/026
> > > index 18529003..0daa7c88 100755
> > > --- a/tests/xfs/026
> > > +++ b/tests/xfs/026
> > > @@ -9,17 +9,8 @@
> > >  . ./common/preamble
> > >  _begin_fstest dump ioctl auto quick
> > >
> > > -status=0       # success is the default!
> > > -
> >
> > All those tests that you change from success is the default
> > to failure is the default, that makes sense, but
> > 1. Should be documented in the commit message?
>
> I cleaned up a bunch of random stuff like this as I went along. If I
> try to document every little change that gets done, I'll be spending
> more time on describing the changes than actually doing them. I
> don't have the time to rigourously document this stuff - I've got
> the time to modify the code, write an overview of the changes and
> that's about it.
>
> What does the fstests community want: better test infrastructure or
> perfect commits?

The former :)

>
> > 2. Why were those tests written this way? Do you know?
>
> That's just the pattern that was used by the team that wrote these
> dump tests 20-odd years ago. At the time nobody cared that much
> about little inconsistencies like this as long as the test failed
> when something went wrong. i.e. test works, merge it, move on to the
> next thing.
>
> Now that we have ~1700 tests to maintain, little inconsistencies are
> a big deal. That's why I cleaned up the simple ones as I saw them...
>

That's super.
Thank you for that.

The reason I am asking is that with kdevops, we observed
some inconsistencies between xunit reported failures and overall run
success/failure.

I was wondering if tests that initialize status=0 could be the source
of these inconsistencies.

Thanks,
Amir.
