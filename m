Return-Path: <fstests-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56313 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713AbbBQQbw (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 17 Feb 2015 11:31:52 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id D2556ABB1
	for <fstests@vger.kernel.org>; Tue, 17 Feb 2015 16:31:50 +0000 (UTC)
Date: Tue, 17 Feb 2015 17:31:49 +0100
From: Jan Kara <jack@suse.cz>
Subject: Test xfs/106 failure
Message-ID: <20150217163149.GA1824@quack.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

  Hello,

  I'm consistently getting failure in xfs/106 test because the files
created by fsstress are just completely different from what they are
expected to be. It almost seems as if the random numbers generated for
fsstress are different. Anyone has seen this as well?

								Honza

-- 
Jan Kara <jack@suse.cz>
SUSE Labs, CR
