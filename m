Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:41129 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015AbaIQJg6 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Sep 2014 05:36:58 -0400
Received: by mail-lb0-f182.google.com with SMTP id u10so1395442lbd.41
        for <fstests@vger.kernel.org>; Wed, 17 Sep 2014 02:36:57 -0700 (PDT)
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: Re: Performance testing
In-Reply-To: <1410943724.31777.31.camel@jtulak>
References: <1410943724.31777.31.camel@jtulak>
Date: Wed, 17 Sep 2014 13:36:54 +0400
Message-ID: <87iokmtwp5.fsf@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>, fstests@vger.kernel.org
Cc: Lukas Czerner <lczerner@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Wed, 17 Sep 2014 10:48:44 +0200, Jan Tulak <jtulak@redhat.com> wrote:
> Hi,
> 
> I have began to work on some set of performance tests. I think it would
> be useful to have some standard set, because as far as I know, there is
> just little of performance testing and every of the few tests someone
> does is unique. I want to propose my ideas before I start to really
> write it, to fix possible complications.
> 
> Mixing performance with regressions tests wouldn't be a good idea, so I
> thought about creating another category on the main level of tests
> (something like xfstests/tests/performance). Or it would be better to
> put it into entirely new directory, like xfstests/performance?
> 
> From the beginning there would be some basic test cases, like sync/async
> read and write. Hopefully more natural cases, like a database server
> would be added later. For the IO testing, I want to use FIO for the
> specific workflow and eventually iozone for the basic synthetic tests.
> 
> What I'm not sure is how a comparison between different versions could
> be done, because I don't see any infrastructure within fstests for
> cross-version comparison. (What would it do with regression tests
> anyway...) So I wonder if it should be done in this set at all. So the
> set would only print the measured values. Some other tool (which can be
> also included, but is not directly part of the performance tests set)
> could then be used to compare and/or plot graphs.
> 
> Comments and questions? :-)
This kind of functionality already implemented in autotest via perf keyval
http://autotest.readthedocs.org/en/latest/main/local/Keyval.html
test case may produce any numbers of keyvalues which will be
automatically stored to standard database for later comparison.
> 
> Jan Tulak
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
