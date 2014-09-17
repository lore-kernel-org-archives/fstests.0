Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1375 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754025AbaIQIsr (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 17 Sep 2014 04:48:47 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8H8ml7a020327
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 17 Sep 2014 04:48:47 -0400
Message-ID: <1410943724.31777.31.camel@jtulak>
Subject: Performance testing
From: Jan Tulak <jtulak@redhat.com>
Date: Wed, 17 Sep 2014 10:48:44 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Lukas Czerner <lczerner@redhat.com>
List-ID: <fstests@vger.kernel.org>

Hi,

I have began to work on some set of performance tests. I think it would
be useful to have some standard set, because as far as I know, there is
just little of performance testing and every of the few tests someone
does is unique. I want to propose my ideas before I start to really
write it, to fix possible complications.

Mixing performance with regressions tests wouldn't be a good idea, so I
thought about creating another category on the main level of tests
(something like xfstests/tests/performance). Or it would be better to
put it into entirely new directory, like xfstests/performance?

>From the beginning there would be some basic test cases, like sync/async
read and write. Hopefully more natural cases, like a database server
would be added later. For the IO testing, I want to use FIO for the
specific workflow and eventually iozone for the basic synthetic tests.

What I'm not sure is how a comparison between different versions could
be done, because I don't see any infrastructure within fstests for
cross-version comparison. (What would it do with regression tests
anyway...) So I wonder if it should be done in this set at all. So the
set would only print the measured values. Some other tool (which can be
also included, but is not directly part of the performance tests set)
could then be used to compare and/or plot graphs.

Comments and questions? :-)

Jan Tulak


