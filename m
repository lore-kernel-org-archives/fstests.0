Received: from bombadil.infradead.org ([198.137.202.133]:43242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbeEDDGf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 May 2018 23:06:35 -0400
Date: Thu, 3 May 2018 20:06:35 -0700
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] check: run auto test group by default
Message-ID: <20180504030635.GB25864@bombadil.infradead.org>
References: <20180504000509.2498-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504000509.2498-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, May 04, 2018 at 10:05:09AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Everyone who starts using fstests runs "check" without parameters,
> and then has problems with it running dangerous tests. most people
> just want fstests to act as a regression test suite, not a fuzzer or
> exercise known crash conditions. Hence make the default behaviour to
> be "run the auto group" rather than "run every test".

Thanks, Dave.  This makes a lot of sense to me.  I don't feel like I
understand the shell script well enough to offer a meaningful review
though.
