Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:33544 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752032AbcAUBoB (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 20 Jan 2016 20:44:01 -0500
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1aM4HL-0001zu-8y
	for fstests@vger.kernel.org; Thu, 21 Jan 2016 12:43:15 +1100
Received: from dave by disappointment with local (Exim 4.86)
	(envelope-from <dave@disappointment.disaster>)
	id 1aM4HL-0002gk-86
	for fstests@vger.kernel.org; Thu, 21 Jan 2016 12:43:15 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 0/3] fstests: improved config section support
Date: Thu, 21 Jan 2016 12:43:10 +1100
Message-Id: <1453340593-10236-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi folks,

This small series adds more functionality to the config file section
support that I've been using locally. It adds support for external
devices to the config section parsing, so we can configure external
log and realtime devices for XFS tests, updates the "setup"
diagnostic command to understand config sections, and adds the
ability to exclude sections from the set that check will pull from
the config file.

-Dave.
