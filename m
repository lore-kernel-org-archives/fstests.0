Received: from imap.thunk.org ([74.207.234.97]:50636 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751369AbdCICgc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 8 Mar 2017 21:36:32 -0500
Date: Wed, 8 Mar 2017 21:10:50 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2] fstests: add the missing _supported_fs to tests
Message-ID: <20170309021050.ulpsfpznr6ajd6e5@thunk.org>
References: <20170308115410.11346-1-eguan@redhat.com>
 <20170308174257.11425-1-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308174257.11425-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 09, 2017 at 01:42:57AM +0800, Eryu Guan wrote:
> There're many tests that are missing _supported_fs check. I first
> noticed this by running ext4/308 under an XFS test config by
> accident then realized that there might be more tests missing
> supported fs type check.

Stupid question --- I had assumed that all tests in xfs/* were
implicitly xfs-only and all tests in btrfs/* were implicitly
btrfs/only, and so on.  Is that not true?

	    	   	   	- Ted
