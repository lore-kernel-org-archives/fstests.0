Received: from mx2.suse.de ([195.135.220.15]:60976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964786AbeF0QDP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 27 Jun 2018 12:03:15 -0400
Date: Wed, 27 Jun 2018 18:03:13 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH] xfstests: fix install target using sudo
Message-ID: <20180627160313.GB5527@wotan.suse.de>
References: <20180626210834.24220-1-mcgrof@kernel.org>
 <20180627074219.GK13748@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627074219.GK13748@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 27, 2018 at 05:42:19PM +1000, Dave Chinner wrote:
> On Tue, Jun 26, 2018 at 02:08:34PM -0700, Luis R. Rodriguez wrote:
> 
> In fact, $(CURDIR) is basically what the current code intends - I
> didn't know this existed because it's not obviously searchable (i.e.
> not a CWD or PWD variant) so I hacked around it with environment
> variables.
> 
> So AFAICT, the change the needs to be made here is:
> 
> -TESTS_SUBDIRS = $(sort $(dir $(wildcard $(PWD)/$(TESTS_DIR)/[a-z]*/)))
> +TESTS_SUBDIRS = $(sort $(dir $(wildcard $(CURDIR)/[a-z]*/)))

You are right, I botched my test with it and used CURDIR with TEST_DIR,
removing it as you did works. Will send a v2.

  Luis
