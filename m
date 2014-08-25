Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:58578 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755138AbaHYWec (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 25 Aug 2014 18:34:32 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1XM2q1-0008PY-Mo
	for fstests@vger.kernel.org; Tue, 26 Aug 2014 08:34:09 +1000
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1XM2q1-0008Cg-Lb
	for fstests@vger.kernel.org; Tue, 26 Aug 2014 08:34:09 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 0/2] xfstests: regression fixes
Date: Tue, 26 Aug 2014 08:34:01 +1000
Message-Id: <1409006043-31495-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi folks,

The following two patch clean up test failures as a result of recent
commits. The update to always check the scratch device caused
widespread false positive failures on xfs specific tests, so the
first patch addresses that. The second patch addresses test failures
due to the format of an xfs_repair error message changing.

-Dave.
