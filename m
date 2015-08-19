Received: from sandeen.net ([63.231.237.45]:45120 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751435AbbHSDfL (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 18 Aug 2015 23:35:11 -0400
Message-ID: <55D3F96E.2010906@sandeen.net>
Date: Tue, 18 Aug 2015 22:35:10 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/194: fix the exception when run on 4k sector drives
References: <1439918511-2859-1-git-send-email-zlang@redhat.com> <20150818222832.GF3902@dastard> <55D3B2A1.2020307@redhat.com> <20150818224351.GG3902@dastard> <55D3B9D1.6030609@sandeen.net> <20150819024216.GH3902@dastard>
In-Reply-To: <20150819024216.GH3902@dastard>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Eric Sandeen <sandeen@redhat.com>, Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 8/18/15 9:42 PM, Dave Chinner wrote:

> if [ $sector_size > $page_size / 8 ]; then
> 	_not_run "sector size too large for platform page size"
> fi
> 
> and replace the hard coded 512 with $sector_size.

I agree.

-Eric

