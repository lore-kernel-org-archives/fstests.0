Received: from bombadil.infradead.org ([65.50.211.133]:48110 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbdJETqc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 5 Oct 2017 15:46:32 -0400
Date: Thu, 5 Oct 2017 12:46:29 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/4] bulkstat_unlink_test_modified: Remove extraneous if
 statement
Message-ID: <20171005194629.GA21115@infradead.org>
References: <1507207800-5688-1-git-send-email-rostislav@tuxera.com>
 <1507207800-5688-4-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507207800-5688-4-git-send-email-rostislav@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Rostislav Skudnov <rostislav@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

> bulkstat_unlink_test_modified.c:171:26: warning: equality comparison
> with extraneous parentheses [-Wparentheses-equality]
>                     if ((ret[i].bs_ino == inodelist[j])) {

Which the patch doesn't seem to actually remove..

> -		    if ((ret[i].bs_ino == inodelist[j])) {
> -			if ((genlist[j] + 1) != ret[i].bs_gen) {

module any reindentation this should be:

		if (ret[i].bs_ino == inodelist[j]) {
			if (genlist[j] + 1 != ret[i].bs_gen) {

alththough merging both conditionals also seems fine to me, as would
putting the ret array on the same side of both, e.g. something like:

		if (ret[i].bs_ino == inodelist[j] &&
		    ret[i].bs_gen != genlist[j]) {
