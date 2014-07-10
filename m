Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:30551 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751213AbaGJUuP (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 10 Jul 2014 16:50:15 -0400
Date: Fri, 11 Jul 2014 06:50:11 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] xfstests: Check fs consistency on TEST_DEV only when
 needed
Message-ID: <20140710205011.GL4453@dastard>
References: <1403617014-17870-1-git-send-email-lczerner@redhat.com>
 <1403617014-17870-2-git-send-email-lczerner@redhat.com>
 <20140710010711.GJ4453@dastard>
 <alpine.LFD.2.00.1407101031150.2659@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LFD.2.00.1407101031150.2659@localhost.localdomain>
Sender: fstests-owner@vger.kernel.org
To: =?utf-8?B?THVrw6HFoQ==?= Czerner <lczerner@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 10, 2014 at 10:38:45AM +0200, Lukáš Czerner wrote:
> On Thu, 10 Jul 2014, Dave Chinner wrote:
> I like the idea Eric proposed with the _require_test check for the
> test that actually require test device and then actually check the
> device only after such test. Will that be acceptable ? If so I'll
> rework the patches.

Works for me. Don't forget to add it to the "new" script as well
so the default is to check the test device. That will trigger us to
check if it is necessary during test development review, rather than
forgetting we need to add it. ;)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
