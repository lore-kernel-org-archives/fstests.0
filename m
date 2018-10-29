Received: from mail-qk1-f193.google.com ([209.85.222.193]:41191 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbeJ2Wd0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 29 Oct 2018 18:33:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id 189so3490827qkj.8
        for <fstests@vger.kernel.org>; Mon, 29 Oct 2018 06:44:42 -0700 (PDT)
Date: Mon, 29 Oct 2018 09:44:36 -0400
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: Re: [PATCH] check: skip parsing if the file is not shell script.
Message-ID: <20181029134435.lx5otokns2pwfvyq@gabell>
References: <20181024143307.25372-1-msys.mizuma@gmail.com>
 <20181028134452.GE3876@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181028134452.GE3876@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

On Sun, Oct 28, 2018 at 09:44:52PM +0800, Eryu Guan wrote:
> On Wed, Oct 24, 2018 at 10:33:07AM -0400, Masayoshi Mizuma wrote:
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > 
> > If we run tests using '*', for example './check xfs/*', we will
> > get following error messages. This patch introduces to avoid
> > the messages.
> > 
> > ./check xfs/*
> > xfs/001.out - unknown test, ignored
> > xfs/002.out - unknown test, ignored
> > xfs/003.out - unknown test, ignored
> > xfs/004.out - unknown test, ignored
> > ...
> 
> Hmm, that's just not the recommended way to run tests. Not all tests are
> valid (yes, there're broken tests) and sometimes we may forget to add x
> permission on a test (though I have a local script to catch that, but it
> did happen before).

Got it, thanks!

> Please either use a more precise pattern to match the tests you want to
> run, or even better, run tests by specifying the groups, e.g.
> 
> ./check -g xfs/log
> 
> to run all tests in 'log' group in 'xfs' directory.

What is the better way to run all the tests?
Should I set the all groups? look like check -g xfs/auto,xfs/ioctl,...?

Thanks,
Masa
