Received: from imap.thunk.org ([74.207.234.97]:38456 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752364AbcF2NQi (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 29 Jun 2016 09:16:38 -0400
Date: Wed, 29 Jun 2016 09:16:34 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] generic/082: rename _filter_project_quota to a avoid
 function name conflict
Message-ID: <20160629131634.GA9546@thunk.org>
References: <1467163987-11242-1-git-send-email-tytso@mit.edu>
 <20160629061109.GS27480@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160629061109.GS27480@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 29, 2016 at 04:11:09PM +1000, Dave Chinner wrote:
> Functions starting with "_" denote common scope functions (i.e.
> from externally sourced files), not local test functions. Just
> remove the "_" prefix here....

Thanks, I wasn't aware of that convention when I first introduced
_filter_project_quota to generic/082.  New patch coming up...

		      	 	       	   - Ted
