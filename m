Received: from imap.thunk.org ([74.207.234.97]:33762 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978AbcBJXVT (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Feb 2016 18:21:19 -0500
Date: Wed, 10 Feb 2016 18:21:15 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 04/12] generic: add _require_odirect to three more tests
Message-ID: <20160210232115.GJ26922@thunk.org>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
 <1455069001-17846-5-git-send-email-tytso@mit.edu>
 <20160210091513.GX11419@eguan.usersys.redhat.com>
 <20160210161135.GG26922@thunk.org>
 <20160210225123.GZ19486@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160210225123.GZ19486@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, hughd@google.com
List-ID: <fstests@vger.kernel.org>

On Thu, Feb 11, 2016 at 09:51:23AM +1100, Dave Chinner wrote:
> Keep in mind this was ported from a CXFS test, where the metadata
> server did the truncation operation (including the data zeroing),
> but the reads are being done from the client.  i.e. it was designed
> to test whether a remote machine is doing a truncate correctly on a
> access shared disk.

Maybe the Ceph folks would care?  But I'm happy to replace this with a
test that just nukes generic/125.

							- Ted
