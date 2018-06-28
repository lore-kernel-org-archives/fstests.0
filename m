Received: from mail-pg0-f67.google.com ([74.125.83.67]:44517 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeF1F7b (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Jun 2018 01:59:31 -0400
Received: by mail-pg0-f67.google.com with SMTP id b10-v6so1981850pgq.11
        for <fstests@vger.kernel.org>; Wed, 27 Jun 2018 22:59:30 -0700 (PDT)
Date: Thu, 28 Jun 2018 13:59:25 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 0/6] fstests: start factoring test setup boilerplate
Message-ID: <20180628055925.GU2780@desktop>
References: <20180627082103.9662-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627082103.9662-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 27, 2018 at 06:20:55PM +1000, Dave Chinner wrote:
> Hi folks,
> 
> These patches start the long process of factoring out most of the
> test setup boilerplate in each test. The first patch introduces the
> generic test setup include file, and the patches that follow start
> the process of converting tests over to use it.
> 
> Making infrastructure changes to fstests is hard because of the
> sheer number of tests. Abstracting out things like test setup will
> make it much easier in future to improve the test setup
> infrstructure as we won't need to modify every test to make the
> change. We only have to do the hard work once.
> 
> There is still some boiler plate in the preamble, but it is reduced
> significantly and only contains things that individual tests should
> be allowed to influence. i.e. the full output file and a cleanup
> function that is called on exit.
> 
> I've also replaced the test success suffix - instead of this boiler
> plate at the end of each test:
> 
> # success, all done
> status=0
> exit
> 
> This has been replaced with a single call to _success, which does
> all the things necessary for the test harness to know the test has
> exited successfully.
> 
> As an initial pass I've convert all the test directories with a
> small number of tests, and converted the first handful of tests in
> each of the major test directories. This is a slow process because
> it's mostly manual as every second test has some unique variation
> that makes automated replacement somewhat difficult.

Sounds good to me. I'll continue commit in new tests using old template
until this patchset goes in. Once these patches are upstream, all new
tests should use new template, I'll convert the pending new tests on
commit or ask the author to do so.

> 
> As such, I've really only scratched the surface - this patchset
> changes over about 60 tests, and there are about 1200 more tests to
> convert. As such, my focus is going to be converting the generic
> tests first - this is the biggest chunk of the work that
> needs to be done.
> 
> Given there is still a large amount of conversion work to do, I
> would appreciate it if people regularly contributing to the other
> large test dirs (mainly overlay, btrfs, ext4 and xfs) would consider
> devoting an hour or two to converting some of those tests to the new
> setup preamble. The more people who do a bit, the faster the
> conversion will go and the better it will be for everyone.

Agreed. And manual conversion also means all the converted tests need
careful review and testings, I'll take some time reviewing & testing
this first batch.

Thanks a lot for doing the hard work in converting the tests!

Eryu

> 
> Comments, thoughts?
> 
> -Dave.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
