Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:53941 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916AbbCTQLc (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 20 Mar 2015 12:11:32 -0400
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.4])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id 19E2463C3A21
	for <fstests@vger.kernel.org>; Fri, 20 Mar 2015 11:11:31 -0500 (CDT)
Message-ID: <550C46B2.8060407@sandeen.net>
Date: Fri, 20 Mar 2015 11:11:30 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: [PATCH 0/2] fstests: rudimentary overlayfs testing
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

2 patches to facilitate rudimentary overlayfs testing.

this doesn't test anything specific to overlayfs, but runs every existing test on top of an overlayfs upper directory.

Most pass; some fail - I have not yet sorted through the results.

How useful this is, I'm not sure, but it doesn't seem too invasive, so is perhaps worth considering.

Thanks,
-Eric
