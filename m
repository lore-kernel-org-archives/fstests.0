Received: from nebula-exfe-02.nebula.fi ([83.145.198.164]:55912 "EHLO
	ex10.nebula.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750725AbbH0LCy (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 27 Aug 2015 07:02:54 -0400
Message-ID: <1440673336.29614.17.camel@ari-macbook>
Subject: Re: [PATCH 2/2] Add some missing symlinks and hardlinks
 requirements.
From: Ari Sundholm <ari@tuxera.com>
Date: Thu, 27 Aug 2015 14:02:16 +0300
In-Reply-To: <20150827014822.GJ3902@dastard>
References: <1440580548.29614.6.camel@ari-macbook>
	 <20150827014822.GJ3902@dastard>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hello Dave!

On Thu, 2015-08-27 at 11:48 +1000, Dave Chinner wrote:
> This belongs in the previous patch that introduced the check.

OK, I will combine the hard link part of the patches, but I think in
this case the symlink part should have its own patch as it is sort of
unrelated (even though it's a very small change by itself).

Best regards,
Ari Sundholm
ari@tuxera.com

