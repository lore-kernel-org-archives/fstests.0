Received: from mx1.redhat.com ([209.132.183.28]:47896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfHWJZn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 23 Aug 2019 05:25:43 -0400
From: Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH] t_stripealign: Fix fibmap error handling
Date: Fri, 23 Aug 2019 11:25:30 +0200
Message-Id: <20190823092530.11797-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

FIBMAP only returns a negative value when the underlying filesystem does
not support FIBMAP or on permission error. For the remaining errors,
i.e. those usually returned from the filesystem itself, zero will be
returned.

We can not trust a zero return from the FIBMAP, and such behavior made
generic/223 succeed when it should not.

Also, we can't use perror() only to print errors when FIBMAP failed, or
it will simply print 'success' when a zero is returned.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 src/t_stripealign.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/t_stripealign.c b/src/t_stripealign.c
index 5cdadaae..164831f8 100644
--- a/src/t_stripealign.c
+++ b/src/t_stripealign.c
@@ -76,8 +76,11 @@ int main(int argc, char ** argv)
 		unsigned int	bmap = 0;
 
 		ret = ioctl(fd, FIBMAP, &bmap);
-		if (ret < 0) {
-			perror("fibmap");
+		if (ret <= 0) {
+			if (ret < 0)
+				perror("fibmap");
+			else
+				fprintf(stderr, "fibmap error\n");
 			free(fie);
 			close(fd);
 			return 1;
-- 
2.20.1
