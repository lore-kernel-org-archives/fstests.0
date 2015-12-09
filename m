Received: from bombadil.infradead.org ([198.137.202.9]:55884 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbbLIPRJ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 9 Dec 2015 10:17:09 -0500
Date: Wed, 9 Dec 2015 07:17:07 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/3] common: Improve _link_output_file to be more
 versatile
Message-ID: <20151209151707.GA17680@infradead.org>
References: <1448361598-28438-1-git-send-email-jack@suse.cz>
 <1448361598-28438-3-git-send-email-jack@suse.cz>
 <20151207232619.GC3094@thunk.org>
 <20151209122707.GE3137@quack.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151209122707.GE3137@quack.suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org, linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>
List-ID: <fstests@vger.kernel.org>

Maybe it's time to drop IRIX support?  I'm pretty sure it hasn't worked
for a long time..
