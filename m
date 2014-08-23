Return-Path: <fstests-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45877 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbaHWLtu (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sat, 23 Aug 2014 07:49:50 -0400
Date: Sat, 23 Aug 2014 04:49:50 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/2] CIFS support for XFS test suite
Message-ID: <20140823114950.GB24896@infradead.org>
References: <1408781763-30127-1-git-send-email-pshilovsky@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1408781763-30127-1-git-send-email-pshilovsky@samba.org>
Sender: fstests-owner@vger.kernel.org
To: Pavel Shilovsky <pshilovsky@samba.org>
Cc: fstests@vger.kernel.org, linux-cifs@vger.kernel.org, David Disseldorp <ddiss@suse.de>, Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Sat, Aug 23, 2014 at 12:16:01PM +0400, Pavel Shilovsky wrote:
> These are two patches that adds CIFS support to XFS tests.
> 
> The first patch adds "-cifs" command line argument and CIFS specific variables. The second patch setups a directory tree for possible CIFS specific tests.
> 
> With these patches applied, most of generic/shared $TEST_DEV tests pass for the recent kernel cifs module.

That's against an smb1 server with posix extentions?  don't you need
various new _require_foo checks for things not support on normal
SMB1/2/3?

