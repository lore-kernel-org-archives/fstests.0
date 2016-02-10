Received: from imap.thunk.org ([74.207.234.97]:57408 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170AbcBJQLh (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Feb 2016 11:11:37 -0500
Date: Wed, 10 Feb 2016 11:11:35 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 04/12] generic: add _require_odirect to three more tests
Message-ID: <20160210161135.GG26922@thunk.org>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-5-git-send-email-tytso@mit.edu>
 <20160210091513.GX11419@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160210091513.GX11419@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Wed, Feb 10, 2016 at 05:15:13PM +0800, Eryu Guan wrote:
> 
> generic/125 only runs "./src/ftrunc" and I don't see where O_DIRECT is
> being used, did I miss anything?

generic/125 also calls "src/trunc", which does use O_DIRECT.

(Hmm, and it assumes '.' is in the test's path, which I don't think is
a safe thing to do.)

					- Ted
