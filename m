Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:20169 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752470AbbBXW7r (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 24 Feb 2015 17:59:47 -0500
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1YQONF-0004vw-UT
	for fstests@vger.kernel.org; Wed, 25 Feb 2015 09:54:41 +1100
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1YQONF-0002fw-TF
	for fstests@vger.kernel.org; Wed, 25 Feb 2015 09:54:41 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH v2 0/4] fstests: sector size fixes and whiteouts...
Date: Wed, 25 Feb 2015 09:54:35 +1100
Message-Id: <1424818479-10083-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi folks,

Version 2 of the patchset I sent yesterday here:

http://thread.gmane.org/gmane.comp.file-systems.fstests/293

V2:
- log size too small for other tests as well (e.g. xfs/297) so
  added them to patch 1/4
- realised I'd only updated the external log file output for xfs/096
  in patch 2/4, so fixed that and updated the filtering to handle
  differences in log version as crc enabled ffilesystems override
  the log version given on the CLI.

