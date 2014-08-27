Return-Path: <fstests-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:53266 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932603AbaH0Wut (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 27 Aug 2014 18:50:49 -0400
Date: Wed, 27 Aug 2014 15:50:47 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 3/3] cifs: skip tests that need POSIX support for
 nounix mounts
Message-ID: <20140827225047.GA4239@infradead.org>
References: <1409084918-17764-1-git-send-email-pshilovsky@samba.org>
 <1409084918-17764-4-git-send-email-pshilovsky@samba.org>
 <20140827155832.GA3103@infradead.org>
 <2DA51A6D-2D91-4582-831B-23C997C37543@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2DA51A6D-2D91-4582-831B-23C997C37543@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Pavel Shilovsky <piastryyy@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Pavel Shilovsky <pshilovsky@samba.org>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>, "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, "samba-technical@samba.org" <samba-technical@samba.org>, David Disseldorp <ddiss@suse.de>, Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 27, 2014 at 11:49:56PM +0400, Pavel Shilovsky wrote:
> So for these tests we need two check functions: _require_symlink for 005,
> 023, 024, 025 and _require_fcntl for 131. Right?

More or less. I'd call the second one _require_fcntl_locks as fcntl
is a multiplexer for tons of unrelated functionality.

