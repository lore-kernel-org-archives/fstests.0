Received: from bombadil.infradead.org ([198.137.202.9]:33652 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529AbbG3RKW (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jul 2015 13:10:22 -0400
Date: Thu, 30 Jul 2015 10:10:20 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 6/6] xfsprogs: add missing include of <stat.h>
Message-ID: <20150730171020.GC25395@infradead.org>
References: <1437913255-7524-1-git-send-email-tytso@mit.edu>
 <1437913255-7524-7-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1437913255-7524-7-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: xfs@oss.sgi.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This looks fine, but hopefull this file will be gone for the next
major release anyway.
