Received: from mga07.intel.com ([134.134.136.100]:45400 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfIREQH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Sep 2019 00:16:07 -0400
From: ira.weiny@intel.com
Subject: [PATCH 03/13] src/locktest: Change command macro names
Date: Tue, 17 Sep 2019 21:15:48 -0700
Message-Id: <20190918041558.2621-4-ira.weiny@intel.com>
In-Reply-To: <20190918041558.2621-1-ira.weiny@intel.com>
References: <20190918041558.2621-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

The macro names for commands are not consistent.  Change them such that
they are not confused with other flags and macros within the test.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 src/locktest.c | 546 ++++++++++++++++++++++++-------------------------
 1 file changed, 273 insertions(+), 273 deletions(-)

diff --git a/src/locktest.c b/src/locktest.c
index b5e1cf7669d8..ce04ecba6205 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -87,13 +87,13 @@ static SOCKET	s_fd = -1;              /* listen socket    */
 static SOCKET	c_fd = -1;	        /* IPC socket       */
 static HANDLE	f_fd = INVALID_HANDLE;	/* shared file      */
 
-#define 	WRLOCK	0
-#define 	RDLOCK	1
-#define		UNLOCK	2
-#define		F_CLOSE	3
-#define		F_OPEN	4
-#define		WRTEST	5
-#define		RDTEST	6
+#define 	CMD_WRLOCK	0
+#define 	CMD_RDLOCK	1
+#define		CMD_UNLOCK	2
+#define		CMD_CLOSE	3
+#define		CMD_OPEN	4
+#define		CMD_WRTEST	5
+#define		CMD_RDTEST	6
 
 #define		PASS 	1
 #define		FAIL	0
@@ -175,361 +175,361 @@ static int64_t tests[][6] =
 	{ 	
 	/* Various simple tests exercising the list */
 
-/* SECTION 1: WRITE and UNLOCK with the same process (SERVER) */
+/* SECTION 1: WRITE and CMD_UNLOCK with the same process (SERVER) */
 	/* Add a lock to an empty list */
-		{1,	WRLOCK,	1,		10,		PASS,		SERVER	}, 
-		{1,	UNLOCK,	1,		10,		PASS,		SERVER	}, 
+		{1,	CMD_WRLOCK,	1,		10,		PASS,		SERVER	}, 
+		{1,	CMD_UNLOCK,	1,		10,		PASS,		SERVER	}, 
 		
 	/* Add a lock to the start and end of a list - 1, 13 - no overlap */
-		{2,	WRLOCK,	10,		10,		PASS,		SERVER	}, 
-		{2,	WRLOCK,	30,		10,		PASS,		SERVER	}, 
-		{2,	WRLOCK,	50,		10,		PASS,		SERVER	}, 
-		{2,	WRLOCK,	1,		5,		PASS,		SERVER	}, 
-		{2,	WRLOCK,	70,		5,		PASS,		SERVER	}, 
+		{2,	CMD_WRLOCK,	10,		10,		PASS,		SERVER	}, 
+		{2,	CMD_WRLOCK,	30,		10,		PASS,		SERVER	}, 
+		{2,	CMD_WRLOCK,	50,		10,		PASS,		SERVER	}, 
+		{2,	CMD_WRLOCK,	1,		5,		PASS,		SERVER	}, 
+		{2,	CMD_WRLOCK,	70,		5,		PASS,		SERVER	}, 
 		
-		{2,	UNLOCK,	10,		10,		PASS,		SERVER	}, 
-		{2,	UNLOCK,	30,		10,		PASS,		SERVER	}, 
-		{2,	UNLOCK,	50,		10,		PASS,		SERVER	}, 
-		{2,	UNLOCK,	1,		5,		PASS,		SERVER	}, 
-		{2,	UNLOCK,	70,		5,		PASS,		SERVER	}, 
+		{2,	CMD_UNLOCK,	10,		10,		PASS,		SERVER	}, 
+		{2,	CMD_UNLOCK,	30,		10,		PASS,		SERVER	}, 
+		{2,	CMD_UNLOCK,	50,		10,		PASS,		SERVER	}, 
+		{2,	CMD_UNLOCK,	1,		5,		PASS,		SERVER	}, 
+		{2,	CMD_UNLOCK,	70,		5,		PASS,		SERVER	}, 
 		
 	/* Add a lock to the middle of a list - no overlap */
-		{3,	WRLOCK,	10,		10,		PASS,		SERVER	}, 
-		{3,	WRLOCK,	30,		10,		PASS,		SERVER	}, 
-		{3,	WRLOCK,	50,		10,		PASS,		SERVER	}, 
-		{3,	WRLOCK,	42,		5,		PASS,		SERVER	}, 
+		{3,	CMD_WRLOCK,	10,		10,		PASS,		SERVER	}, 
+		{3,	CMD_WRLOCK,	30,		10,		PASS,		SERVER	}, 
+		{3,	CMD_WRLOCK,	50,		10,		PASS,		SERVER	}, 
+		{3,	CMD_WRLOCK,	42,		5,		PASS,		SERVER	}, 
 		
-		{3,	UNLOCK,	10,		10,		PASS,		SERVER	}, 
-		{3,	UNLOCK,	30,		10,		PASS,		SERVER	}, 
-		{3,	UNLOCK,	50,		10,		PASS,		SERVER	}, 
-		{3,	UNLOCK,	42,		5,		PASS,		SERVER	}, 
+		{3,	CMD_UNLOCK,	10,		10,		PASS,		SERVER	}, 
+		{3,	CMD_UNLOCK,	30,		10,		PASS,		SERVER	}, 
+		{3,	CMD_UNLOCK,	50,		10,		PASS,		SERVER	}, 
+		{3,	CMD_UNLOCK,	42,		5,		PASS,		SERVER	}, 
 		
 	/* Add different lock types to middle of the list - overlap exact match - 3 */
-		{4,	WRLOCK,	10,		10,		PASS,		SERVER	}, 
-		{4,	WRLOCK,	30,		10,		PASS,		SERVER	}, 
-		{4,	WRLOCK,	50,		10,		PASS,		SERVER	}, 
+		{4,	CMD_WRLOCK,	10,		10,		PASS,		SERVER	}, 
+		{4,	CMD_WRLOCK,	30,		10,		PASS,		SERVER	}, 
+		{4,	CMD_WRLOCK,	50,		10,		PASS,		SERVER	}, 
 		/* Exact match - same lock type */
-		{4,	WRLOCK,	30,		10,		PASS,		SERVER	}, 
+		{4,	CMD_WRLOCK,	30,		10,		PASS,		SERVER	}, 
 		/* Exact match - different lock type */
-		{4,	RDLOCK,	30,		10,		PASS,		SERVER	}, 
+		{4,	CMD_RDLOCK,	30,		10,		PASS,		SERVER	}, 
 		/* Exact match - unlock */
-		{4,	UNLOCK,	30,		10,		PASS,		SERVER	}, 
+		{4,	CMD_UNLOCK,	30,		10,		PASS,		SERVER	}, 
 		/* New lock - as above, inserting in the list again */
-		{4,	WRLOCK,	30,		10,		PASS,		SERVER	}, 
+		{4,	CMD_WRLOCK,	30,		10,		PASS,		SERVER	}, 
 		
-		{4,	UNLOCK,	10,		10,		PASS,		SERVER	}, 
-		{4,	UNLOCK,	30,		10,		PASS,		SERVER	}, 
-		{4,	UNLOCK,	50,		10,		PASS,		SERVER	}, 
+		{4,	CMD_UNLOCK,	10,		10,		PASS,		SERVER	}, 
+		{4,	CMD_UNLOCK,	30,		10,		PASS,		SERVER	}, 
+		{4,	CMD_UNLOCK,	50,		10,		PASS,		SERVER	}, 
 		
 	/* Add new lock which completely overlaps any old lock in the list - 4,5,6 */
-		{5,	WRLOCK,	10,		10,		PASS,		SERVER	}, 
-		{5,	WRLOCK,	30,		10,		PASS,		SERVER	}, 
-		{5,	WRLOCK,	50,		10,		PASS,		SERVER	}, 
+		{5,	CMD_WRLOCK,	10,		10,		PASS,		SERVER	}, 
+		{5,	CMD_WRLOCK,	30,		10,		PASS,		SERVER	}, 
+		{5,	CMD_WRLOCK,	50,		10,		PASS,		SERVER	}, 
 		/* The start is the same, end overlaps */
-		{5,	WRLOCK,	30,		15,		PASS,		SERVER	}, 
+		{5,	CMD_WRLOCK,	30,		15,		PASS,		SERVER	}, 
 		/* The start is before, end is the same */
-		{5,	WRLOCK,	25,		20,		PASS,		SERVER	}, 
+		{5,	CMD_WRLOCK,	25,		20,		PASS,		SERVER	}, 
 		/* Both start and end overlap */
-		{5,	WRLOCK,	22,		26,		PASS,		SERVER	}, 
+		{5,	CMD_WRLOCK,	22,		26,		PASS,		SERVER	}, 
 		
-		{5,	UNLOCK,	10,		10,		PASS,		SERVER	}, 
-		{5,	UNLOCK,	22,		26,		PASS,		SERVER	}, 
-		{5,	UNLOCK,	50,		10,		PASS,		SERVER	}, 
+		{5,	CMD_UNLOCK,	10,		10,		PASS,		SERVER	}, 
+		{5,	CMD_UNLOCK,	22,		26,		PASS,		SERVER	}, 
+		{5,	CMD_UNLOCK,	50,		10,		PASS,		SERVER	}, 
 		
 	/* Add new lock which itself is completely overlaped by any old lock in the list - 7,8,10 */
-		{6,	WRLOCK,	10,		10,		PASS,		SERVER	}, 
-		{6,	WRLOCK,	30,		10,		PASS,		SERVER	}, 
-		{6,	WRLOCK,	50,		10,		PASS,		SERVER	}, 
+		{6,	CMD_WRLOCK,	10,		10,		PASS,		SERVER	}, 
+		{6,	CMD_WRLOCK,	30,		10,		PASS,		SERVER	}, 
+		{6,	CMD_WRLOCK,	50,		10,		PASS,		SERVER	}, 
 		/* The start is the same, end is in the middle of old lock - NOP */
-		{6,	WRLOCK,	30,		5,		PASS,		SERVER	}, 
+		{6,	CMD_WRLOCK,	30,		5,		PASS,		SERVER	}, 
 		/* The start and end are in the middle of old lock - NOP */
-		{6,	WRLOCK,	32,		6,		PASS,		SERVER	}, 
+		{6,	CMD_WRLOCK,	32,		6,		PASS,		SERVER	}, 
 		/* Start in the middle and end is the same - NOP */
-		{6,	WRLOCK,	32,		8,		PASS,		SERVER	}, 
+		{6,	CMD_WRLOCK,	32,		8,		PASS,		SERVER	}, 
 		
-		{6,	UNLOCK,	10,		10,		PASS,		SERVER	}, 
-		{6,	UNLOCK,	30,		10,		PASS,		SERVER	}, 
-		{6,	UNLOCK,	32,		8,		PASS,		SERVER	}, 
-		{6,	UNLOCK,	50,		10,		PASS,		SERVER	}, 
+		{6,	CMD_UNLOCK,	10,		10,		PASS,		SERVER	}, 
+		{6,	CMD_UNLOCK,	30,		10,		PASS,		SERVER	}, 
+		{6,	CMD_UNLOCK,	32,		8,		PASS,		SERVER	}, 
+		{6,	CMD_UNLOCK,	50,		10,		PASS,		SERVER	}, 
 		
 	/* Add new lock which starts before any old lock in the list - 2,9 */
-		{7,	WRLOCK,	10,		10,		PASS,		SERVER	}, 
-		{7,	WRLOCK,	30,		10,		PASS,		SERVER	}, 
-		{7,	WRLOCK,	50,		10,		PASS,		SERVER	}, 
+		{7,	CMD_WRLOCK,	10,		10,		PASS,		SERVER	}, 
+		{7,	CMD_WRLOCK,	30,		10,		PASS,		SERVER	}, 
+		{7,	CMD_WRLOCK,	50,		10,		PASS,		SERVER	}, 
 		/* Here is the new lock */
-		{7,	WRLOCK,	27,		10,		PASS,		SERVER	}, 
+		{7,	CMD_WRLOCK,	27,		10,		PASS,		SERVER	}, 
 		/* Go again with the end of the new lock matching the start of old lock */
-		{7,	WRLOCK,	25,		2,		PASS,		SERVER	}, 
+		{7,	CMD_WRLOCK,	25,		2,		PASS,		SERVER	}, 
 		
-		{7,	UNLOCK,	10,		10,		PASS,		SERVER	}, 
-		{7,	UNLOCK,	25,		15,		PASS,		SERVER	}, 
-		{7,	UNLOCK,	50,		10,		PASS,		SERVER	}, 
+		{7,	CMD_UNLOCK,	10,		10,		PASS,		SERVER	}, 
+		{7,	CMD_UNLOCK,	25,		15,		PASS,		SERVER	}, 
+		{7,	CMD_UNLOCK,	50,		10,		PASS,		SERVER	}, 
 	
 	/* Add new lock which starts in the middle of any old lock in the list and ends after - 11,12 */
-		{8,	WRLOCK,	10,		10,		PASS,		SERVER	}, 
-		{8,	WRLOCK,	30,		10,		PASS,		SERVER	}, 
-		{8,	WRLOCK,	50,		10,		PASS,		SERVER	}, 
+		{8,	CMD_WRLOCK,	10,		10,		PASS,		SERVER	}, 
+		{8,	CMD_WRLOCK,	30,		10,		PASS,		SERVER	}, 
+		{8,	CMD_WRLOCK,	50,		10,		PASS,		SERVER	}, 
 		/* Here is the new lock */
-		{8,	WRLOCK,	35,		10,		PASS,		SERVER	}, 
+		{8,	CMD_WRLOCK,	35,		10,		PASS,		SERVER	}, 
 		/* Go again with the end of the new lock matching the start of old lock */
-		{8,	WRLOCK,	45,		2,		PASS,		SERVER	}, 
+		{8,	CMD_WRLOCK,	45,		2,		PASS,		SERVER	}, 
 		
-		{8,	UNLOCK,	10,		10,		PASS,		SERVER	}, 
-		{8,	UNLOCK,	30,		17,		PASS,		SERVER	}, 
-		{8,	UNLOCK,	50,		10,		PASS,		SERVER	}, 
-/* SECTION 2: Overlapping READ and WRITE and UNLOCK with the same process (SERVER) */
+		{8,	CMD_UNLOCK,	10,		10,		PASS,		SERVER	}, 
+		{8,	CMD_UNLOCK,	30,		17,		PASS,		SERVER	}, 
+		{8,	CMD_UNLOCK,	50,		10,		PASS,		SERVER	}, 
+/* SECTION 2: Overlapping READ and WRITE and CMD_UNLOCK with the same process (SERVER) */
 	/* Add different new lock types which completely overlaps any old lock in the list - 4,5,6 */
-		{9,	WRLOCK,	10,		10,		PASS,		SERVER	}, 
-		{9,	WRLOCK,	30,		10,		PASS,		SERVER	}, 
-		{9,	WRLOCK,	50,		10,		PASS,		SERVER	}, 
+		{9,	CMD_WRLOCK,	10,		10,		PASS,		SERVER	}, 
+		{9,	CMD_WRLOCK,	30,		10,		PASS,		SERVER	}, 
+		{9,	CMD_WRLOCK,	50,		10,		PASS,		SERVER	}, 
 		/* The start is the same, end overlaps */
-		{9,	RDLOCK,	30,		15,		PASS,		SERVER	}, 
+		{9,	CMD_RDLOCK,	30,		15,		PASS,		SERVER	}, 
 		/* The start is before, end is the same */
-		{9,	WRLOCK,	25,		20,		PASS,		SERVER	}, 
+		{9,	CMD_WRLOCK,	25,		20,		PASS,		SERVER	}, 
 		/* Both start and end overlap */
-		{9,	RDLOCK,	22,		26,		PASS,		SERVER	}, 
+		{9,	CMD_RDLOCK,	22,		26,		PASS,		SERVER	}, 
 		
-		{9,	UNLOCK,	10,		10,		PASS,		SERVER	}, 
-		{9,	UNLOCK,	22,		26,		PASS,		SERVER	}, 
-		{9,	UNLOCK,	50,		10,		PASS,		SERVER	}, 
+		{9,	CMD_UNLOCK,	10,		10,		PASS,		SERVER	}, 
+		{9,	CMD_UNLOCK,	22,		26,		PASS,		SERVER	}, 
+		{9,	CMD_UNLOCK,	50,		10,		PASS,		SERVER	}, 
 		
 	/* Add different new locks which are completely overlaped by an old lock in the list - 7,8,10 */
-		{10,	WRLOCK,	10,		10,		PASS,		SERVER	}, 
-		{10,	WRLOCK,	30,		10,		PASS,		SERVER	}, 
-		{10,	WRLOCK,	50,		10,		PASS,		SERVER	}, 
+		{10,	CMD_WRLOCK,	10,		10,		PASS,		SERVER	}, 
+		{10,	CMD_WRLOCK,	30,		10,		PASS,		SERVER	}, 
+		{10,	CMD_WRLOCK,	50,		10,		PASS,		SERVER	}, 
 		/* The start is the same, end is in the middle of old lock */
-		{10,	RDLOCK,	30,		5,		PASS,		SERVER	}, 
+		{10,	CMD_RDLOCK,	30,		5,		PASS,		SERVER	}, 
 		/* The start and end are in the middle of a lock */
-		{10,	WRLOCK,	32,		2,		PASS,		SERVER	}, 
+		{10,	CMD_WRLOCK,	32,		2,		PASS,		SERVER	}, 
 		/* Start in the middle and end is the same */
-		{10,	RDLOCK,	36,		5,		PASS,		SERVER	}, 
+		{10,	CMD_RDLOCK,	36,		5,		PASS,		SERVER	}, 
 		
-		{10,	UNLOCK,	10,		10,		PASS,		SERVER	}, 
-		{10,	UNLOCK,	30,		11,		PASS,		SERVER	}, 
-		{10,	UNLOCK,	50,		10,		PASS,		SERVER	}, 
+		{10,	CMD_UNLOCK,	10,		10,		PASS,		SERVER	}, 
+		{10,	CMD_UNLOCK,	30,		11,		PASS,		SERVER	}, 
+		{10,	CMD_UNLOCK,	50,		10,		PASS,		SERVER	}, 
 		
 	/* Add different new lock types which start before the old lock in the list - 2,9 */
-		{11,	WRLOCK,	10,		10,		PASS,		SERVER	}, 
-		{11,	WRLOCK,	30,		10,		PASS,		SERVER	}, 
-		{11,	WRLOCK,	50,		10,		PASS,		SERVER	}, 
+		{11,	CMD_WRLOCK,	10,		10,		PASS,		SERVER	}, 
+		{11,	CMD_WRLOCK,	30,		10,		PASS,		SERVER	}, 
+		{11,	CMD_WRLOCK,	50,		10,		PASS,		SERVER	}, 
 		/* Here is the new lock */
-		{11,	RDLOCK,	27,		10,		PASS,		SERVER	}, 
+		{11,	CMD_RDLOCK,	27,		10,		PASS,		SERVER	}, 
 		/* Go again with the end of the new lock matching the start of lock */
-		{11,	WRLOCK,	25,		3,		PASS,		SERVER	}, 
+		{11,	CMD_WRLOCK,	25,		3,		PASS,		SERVER	}, 
 		
-		{11,	UNLOCK,	10,		10,		PASS,		SERVER	}, 
-		{11,	UNLOCK,	25,		15,		PASS,		SERVER	}, 
-		{11,	UNLOCK,	50,		10,		PASS,		SERVER	}, 
+		{11,	CMD_UNLOCK,	10,		10,		PASS,		SERVER	}, 
+		{11,	CMD_UNLOCK,	25,		15,		PASS,		SERVER	}, 
+		{11,	CMD_UNLOCK,	50,		10,		PASS,		SERVER	}, 
 	
 	/* Add different new lock types which start in the middle of an old lock in the list and end after - 11,12 */
-		{12,	WRLOCK,	10,		10,		PASS,		SERVER	}, 
-		{12,	WRLOCK,	30,		10,		PASS,		SERVER	}, 
-		{12,	WRLOCK,	50,		10,		PASS,		SERVER	}, 
+		{12,	CMD_WRLOCK,	10,		10,		PASS,		SERVER	}, 
+		{12,	CMD_WRLOCK,	30,		10,		PASS,		SERVER	}, 
+		{12,	CMD_WRLOCK,	50,		10,		PASS,		SERVER	}, 
 		/* Here is the new lock */
-		{12,	RDLOCK,	35,		10,		PASS,		SERVER	}, 
+		{12,	CMD_RDLOCK,	35,		10,		PASS,		SERVER	}, 
 		/* Go again with the end of the new lock matching the start of old lock */
-		{12,	WRLOCK,	44,		3,		PASS,		SERVER	}, 
+		{12,	CMD_WRLOCK,	44,		3,		PASS,		SERVER	}, 
 		
-		{12,	UNLOCK,	10,		10,		PASS,		SERVER	}, 
-		{12,	UNLOCK,	30,		18,		PASS,		SERVER	}, 
-		{12,	UNLOCK,	50,		10,		PASS,		SERVER	}, 
+		{12,	CMD_UNLOCK,	10,		10,		PASS,		SERVER	}, 
+		{12,	CMD_UNLOCK,	30,		18,		PASS,		SERVER	}, 
+		{12,	CMD_UNLOCK,	50,		10,		PASS,		SERVER	}, 
 
-/* SECTION 3: Overlapping READ and WRITE and UNLOCK with the different processes (CLIENT/SERVER) */
+/* SECTION 3: Overlapping READ and WRITE and CMD_UNLOCK with the different processes (CLIENT/SERVER) */
 	/* Add new lock, differing types and processes, to middle of the list - exact overlap match - 3 */
-		{13,	WRLOCK,	10,		10,		PASS,		SERVER	}, 
-		{13,	WRLOCK,	30,		10,		PASS,		SERVER	}, 
-		{13,	RDLOCK,	50,		10,		PASS,		SERVER	}, 
+		{13,	CMD_WRLOCK,	10,		10,		PASS,		SERVER	}, 
+		{13,	CMD_WRLOCK,	30,		10,		PASS,		SERVER	}, 
+		{13,	CMD_RDLOCK,	50,		10,		PASS,		SERVER	}, 
 		/* Same lock type, different process */
-		{13,	WRLOCK,	30,		10,		FAIL,		CLIENT	}, 
-		{13,	RDLOCK,	50,		10,		PASS,		CLIENT	}, 
+		{13,	CMD_WRLOCK,	30,		10,		FAIL,		CLIENT	}, 
+		{13,	CMD_RDLOCK,	50,		10,		PASS,		CLIENT	}, 
 		/* Exact match - different lock type, different process */
-		{13,	RDLOCK,	30,		10,		FAIL,		CLIENT	}, 
+		{13,	CMD_RDLOCK,	30,		10,		FAIL,		CLIENT	}, 
 		/* Exact match - unlock */
-		{13,	UNLOCK,	30,		10,		PASS,		CLIENT	}, 
+		{13,	CMD_UNLOCK,	30,		10,		PASS,		CLIENT	}, 
 		/* New lock - as above, inserting in the list again */
-		{13,	UNLOCK,	30,		10,		PASS,		SERVER	}, 
+		{13,	CMD_UNLOCK,	30,		10,		PASS,		SERVER	}, 
 		/* Exact match - same lock type, different process */
-		{13,	WRLOCK,	30,		10,		PASS,		CLIENT	}, 
+		{13,	CMD_WRLOCK,	30,		10,		PASS,		CLIENT	}, 
 		
-		{13,	UNLOCK,	10,		10,		PASS,		SERVER	}, 
-		{13,	UNLOCK,	30,		10,		PASS,		CLIENT	}, 
-		{13,	UNLOCK,	50,		10,		PASS,		SERVER	}, 
+		{13,	CMD_UNLOCK,	10,		10,		PASS,		SERVER	}, 
+		{13,	CMD_UNLOCK,	30,		10,		PASS,		CLIENT	}, 
+		{13,	CMD_UNLOCK,	50,		10,		PASS,		SERVER	}, 
 		
 	/* Add new lock, differing types and processes, which completely overlap any of the locks in the list - 4,5,6 */
-		{14,	WRLOCK,	10,		10,		PASS,		SERVER	}, 
-		{14,	WRLOCK,	30,		10,		PASS,		SERVER	}, 
-		{14,	RDLOCK,	50,		10,		PASS,		SERVER	}, 
+		{14,	CMD_WRLOCK,	10,		10,		PASS,		SERVER	}, 
+		{14,	CMD_WRLOCK,	30,		10,		PASS,		SERVER	}, 
+		{14,	CMD_RDLOCK,	50,		10,		PASS,		SERVER	}, 
 		/* The start is the same, end overlaps */
-		{14,	RDLOCK,	30,		15,		FAIL,		CLIENT	},
-		{14,	WRLOCK,	30,		15,		FAIL,		CLIENT	}, 
+		{14,	CMD_RDLOCK,	30,		15,		FAIL,		CLIENT	},
+		{14,	CMD_WRLOCK,	30,		15,		FAIL,		CLIENT	}, 
 		/* The start is before, end is the same */
-		{14,	RDLOCK,	25,		20,		FAIL,		CLIENT	}, 
-		{14,	WRLOCK,	25,		20,		FAIL,		CLIENT	}, 
+		{14,	CMD_RDLOCK,	25,		20,		FAIL,		CLIENT	}, 
+		{14,	CMD_WRLOCK,	25,		20,		FAIL,		CLIENT	}, 
 		/* Both start and end overlap */
-		{14,	RDLOCK,	22,		26,		FAIL,		CLIENT	}, 
-		{14,	WRLOCK,	22,		26,		FAIL,		CLIENT	}, 
+		{14,	CMD_RDLOCK,	22,		26,		FAIL,		CLIENT	}, 
+		{14,	CMD_WRLOCK,	22,		26,		FAIL,		CLIENT	}, 
 		
 		/* The start is the same, end overlaps */
-		{14,	RDLOCK,	50,		15,		PASS,		CLIENT	},
-		{14,	WRLOCK,	50,		17,		FAIL,		CLIENT	}, 
+		{14,	CMD_RDLOCK,	50,		15,		PASS,		CLIENT	},
+		{14,	CMD_WRLOCK,	50,		17,		FAIL,		CLIENT	}, 
 		/* The start is before, end is the same */
-		{14,	RDLOCK,	45,		20,		PASS,		CLIENT	}, 
-		{14,	WRLOCK,	43,		22,		FAIL,		CLIENT	}, 
+		{14,	CMD_RDLOCK,	45,		20,		PASS,		CLIENT	}, 
+		{14,	CMD_WRLOCK,	43,		22,		FAIL,		CLIENT	}, 
 		/* Both start and end overlap */
-		{14,	RDLOCK,	42,		26,		PASS,		CLIENT	}, 
-		{14,	WRLOCK,	41,		28,		FAIL,		CLIENT	}, 
+		{14,	CMD_RDLOCK,	42,		26,		PASS,		CLIENT	}, 
+		{14,	CMD_WRLOCK,	41,		28,		FAIL,		CLIENT	}, 
 		
-		{14,	UNLOCK,	10,		10,		PASS,		SERVER	}, 
-		{14,	UNLOCK,	22,		26,		PASS,		SERVER	}, 
-		{14,	UNLOCK,	42,		26,		PASS,		CLIENT	}, 
+		{14,	CMD_UNLOCK,	10,		10,		PASS,		SERVER	}, 
+		{14,	CMD_UNLOCK,	22,		26,		PASS,		SERVER	}, 
+		{14,	CMD_UNLOCK,	42,		26,		PASS,		CLIENT	}, 
 
 	/* Add new lock, differing types and processes, which are completely overlaped by an old lock in the list - 7,8,10 */
-		{15,	WRLOCK,	10,		10,		PASS,		SERVER	}, 
-		{15,	RDLOCK,	30,		10,		PASS,		SERVER	}, 
-		{15,	WRLOCK,	50,		10,		PASS,		SERVER	}, 
+		{15,	CMD_WRLOCK,	10,		10,		PASS,		SERVER	}, 
+		{15,	CMD_RDLOCK,	30,		10,		PASS,		SERVER	}, 
+		{15,	CMD_WRLOCK,	50,		10,		PASS,		SERVER	}, 
 		/* The start is the same, end is in the middle of old lock */
-		{15,	RDLOCK,	50,		5,		FAIL,		CLIENT	}, 
-		{15,	WRLOCK,	50,		5,		FAIL,		CLIENT	}, 
+		{15,	CMD_RDLOCK,	50,		5,		FAIL,		CLIENT	}, 
+		{15,	CMD_WRLOCK,	50,		5,		FAIL,		CLIENT	}, 
 		/* The start and end are in the middle of old lock */
-		{15,	RDLOCK,	52,		6,		FAIL,		CLIENT	}, 
-		{15,	WRLOCK,	52,		6,		FAIL,		CLIENT	}, 
+		{15,	CMD_RDLOCK,	52,		6,		FAIL,		CLIENT	}, 
+		{15,	CMD_WRLOCK,	52,		6,		FAIL,		CLIENT	}, 
 		/* Start in the middle and end is the same */
-		{15,	RDLOCK,	52,		8,		FAIL,		CLIENT	}, 
-		{15,	WRLOCK,	52,		8,		FAIL,		CLIENT	}, 
+		{15,	CMD_RDLOCK,	52,		8,		FAIL,		CLIENT	}, 
+		{15,	CMD_WRLOCK,	52,		8,		FAIL,		CLIENT	}, 
 		/* The start is the same, end is in the middle of old lock */
-		{15,	RDLOCK,	30,		5,		PASS,		CLIENT	}, 
-		{15,	WRLOCK,	30,		5,		FAIL,		CLIENT	}, 
+		{15,	CMD_RDLOCK,	30,		5,		PASS,		CLIENT	}, 
+		{15,	CMD_WRLOCK,	30,		5,		FAIL,		CLIENT	}, 
 		/* The start and end are in the middle of old lock */
-		{15,	RDLOCK,	32,		6,		PASS,		CLIENT	}, 
-		{15,	WRLOCK,	32,		6,		FAIL,		CLIENT	}, 
+		{15,	CMD_RDLOCK,	32,		6,		PASS,		CLIENT	}, 
+		{15,	CMD_WRLOCK,	32,		6,		FAIL,		CLIENT	}, 
 		/* Start in the middle and end is the same */
-		{15,	RDLOCK,	32,		8,		PASS,		CLIENT	}, 
-		{15,	WRLOCK,	32,		8,		FAIL,		CLIENT	}, 
+		{15,	CMD_RDLOCK,	32,		8,		PASS,		CLIENT	}, 
+		{15,	CMD_WRLOCK,	32,		8,		FAIL,		CLIENT	}, 
 		
-		{15,	UNLOCK,	10,		10,		PASS,		SERVER	}, 
-		{15,	UNLOCK,	30,		10,		PASS,		SERVER	}, 
-		{15,	UNLOCK,	50,		10,		PASS,		SERVER	}, 
+		{15,	CMD_UNLOCK,	10,		10,		PASS,		SERVER	}, 
+		{15,	CMD_UNLOCK,	30,		10,		PASS,		SERVER	}, 
+		{15,	CMD_UNLOCK,	50,		10,		PASS,		SERVER	}, 
 	/* Add new lock, differing types and processes, which start before a lock in the list - 2,9 */
-		{16,	RDLOCK,	10,		10,		PASS,		SERVER	}, 
-		{16,	WRLOCK,	50,		10,		PASS,		SERVER	}, 
+		{16,	CMD_RDLOCK,	10,		10,		PASS,		SERVER	}, 
+		{16,	CMD_WRLOCK,	50,		10,		PASS,		SERVER	}, 
 		/* Start is before, end is the start of the old lock in list */
-		{16,	RDLOCK,	5,		6,		PASS,		CLIENT	}, 
-		{16,	WRLOCK,	5,		6,		FAIL,		CLIENT	}, 
+		{16,	CMD_RDLOCK,	5,		6,		PASS,		CLIENT	}, 
+		{16,	CMD_WRLOCK,	5,		6,		FAIL,		CLIENT	}, 
 		/* Start is before, end is in the middle of the old lock */
-		{16,	RDLOCK,	5,		10,		PASS,		CLIENT	}, 
-		{16,	WRLOCK,	5,		10,		FAIL,		CLIENT	}, 
+		{16,	CMD_RDLOCK,	5,		10,		PASS,		CLIENT	}, 
+		{16,	CMD_WRLOCK,	5,		10,		FAIL,		CLIENT	}, 
 		/* Start is before, end is the start of the old lock in list */
-		{16,	RDLOCK,	45,		6,		FAIL,		CLIENT	}, 
-		{16,	WRLOCK,	45,		6,		FAIL,		CLIENT	}, 
+		{16,	CMD_RDLOCK,	45,		6,		FAIL,		CLIENT	}, 
+		{16,	CMD_WRLOCK,	45,		6,		FAIL,		CLIENT	}, 
 		/* Start is before, end is in the middle of the old lock */
-		{16,	RDLOCK,	45,		10,		FAIL,		CLIENT	}, 
-		{16,	WRLOCK,	45,		10,		FAIL,		CLIENT	}, 
+		{16,	CMD_RDLOCK,	45,		10,		FAIL,		CLIENT	}, 
+		{16,	CMD_WRLOCK,	45,		10,		FAIL,		CLIENT	}, 
 		
-		{16,	UNLOCK,	5,		15,		PASS,		CLIENT	}, 
-		{16,	UNLOCK,	30,		10,		PASS,		SERVER	}, 
-		{16,	UNLOCK,	50,		10,		PASS,		SERVER	}, 
+		{16,	CMD_UNLOCK,	5,		15,		PASS,		CLIENT	}, 
+		{16,	CMD_UNLOCK,	30,		10,		PASS,		SERVER	}, 
+		{16,	CMD_UNLOCK,	50,		10,		PASS,		SERVER	}, 
 
 	/* Add new lock, differing types and processes, which starts in the middle of a lock, and ends after - 11,12 */
-		{17,	WRLOCK,	10,		10,		PASS,		SERVER	}, 
-		{17,	RDLOCK,	30,		10,		PASS,		SERVER	}, 
-		{17,	WRLOCK,	50,		10,		PASS,		SERVER	}, 
+		{17,	CMD_WRLOCK,	10,		10,		PASS,		SERVER	}, 
+		{17,	CMD_RDLOCK,	30,		10,		PASS,		SERVER	}, 
+		{17,	CMD_WRLOCK,	50,		10,		PASS,		SERVER	}, 
 		/* Start in the middle, end after lock in list */
-		{17,	WRLOCK,	35,		10,		FAIL,		CLIENT	}, 
+		{17,	CMD_WRLOCK,	35,		10,		FAIL,		CLIENT	}, 
 		/* Start matches end of lock in list  */
-		{17,	RDLOCK,	35,		10,		PASS,		CLIENT	}, 
-		{17,	RDLOCK,	44,		2,		PASS,		CLIENT	}, 
+		{17,	CMD_RDLOCK,	35,		10,		PASS,		CLIENT	}, 
+		{17,	CMD_RDLOCK,	44,		2,		PASS,		CLIENT	}, 
 		/* Start in the middle, end after lock in list */
-		{17,	RDLOCK,	55,		10,		FAIL,		CLIENT	}, 
-		{17,	WRLOCK,	55,		10,		FAIL,		CLIENT	}, 
+		{17,	CMD_RDLOCK,	55,		10,		FAIL,		CLIENT	}, 
+		{17,	CMD_WRLOCK,	55,		10,		FAIL,		CLIENT	}, 
 		/* Start matches end of lock in list  */
-		{17,	RDLOCK,	59,		5,		FAIL,		CLIENT	}, 
-		{17,	WRLOCK,	59,		5,		FAIL,		CLIENT	}, 
+		{17,	CMD_RDLOCK,	59,		5,		FAIL,		CLIENT	}, 
+		{17,	CMD_WRLOCK,	59,		5,		FAIL,		CLIENT	}, 
 		
-		{17,	UNLOCK,	10,		10,		PASS,		SERVER	}, 
-		{17,	UNLOCK,	30,		16,		PASS,		CLIENT	}, 
-		{17,	UNLOCK,	50,		10,		PASS,		SERVER	}, 
+		{17,	CMD_UNLOCK,	10,		10,		PASS,		SERVER	}, 
+		{17,	CMD_UNLOCK,	30,		16,		PASS,		CLIENT	}, 
+		{17,	CMD_UNLOCK,	50,		10,		PASS,		SERVER	}, 
 
 /* SECTION 4: overlapping and EOF tests */
 	/* Acquire overlapping ranges */
-		{18,	WRLOCK,	11,		7,		PASS,		SERVER	},
-		{18,	WRLOCK,	13,		8,		FAIL,		CLIENT	},
-		{18,	UNLOCK,	11,		7,		PASS,		SERVER	},
+		{18,	CMD_WRLOCK,	11,		7,		PASS,		SERVER	},
+		{18,	CMD_WRLOCK,	13,		8,		FAIL,		CLIENT	},
+		{18,	CMD_UNLOCK,	11,		7,		PASS,		SERVER	},
 	/* Acquire different ranges beyond EOF */
-		{19,	WRLOCK,	10,		FILE_SIZE,	PASS,		SERVER	},
-		{19,	WRLOCK,	FILE_SIZE + 10,	10,		PASS,		CLIENT	},
-		{19,	UNLOCK,	10,		FILE_SIZE,	PASS,		SERVER	},
-		{19,	UNLOCK,	FILE_SIZE + 10,	10,		PASS,		CLIENT	},
+		{19,	CMD_WRLOCK,	10,		FILE_SIZE,	PASS,		SERVER	},
+		{19,	CMD_WRLOCK,	FILE_SIZE + 10,	10,		PASS,		CLIENT	},
+		{19,	CMD_UNLOCK,	10,		FILE_SIZE,	PASS,		SERVER	},
+		{19,	CMD_UNLOCK,	FILE_SIZE + 10,	10,		PASS,		CLIENT	},
 	/* Acquire same range beyong EOF */
-		{20,	WRLOCK,	10,		FILE_SIZE,	PASS,		SERVER,	},
-		{20,	WRLOCK,	10,		FILE_SIZE,	FAIL,		CLIENT,	},
-		{20,	UNLOCK,	10,		FILE_SIZE,	PASS,		SERVER,	},
+		{20,	CMD_WRLOCK,	10,		FILE_SIZE,	PASS,		SERVER,	},
+		{20,	CMD_WRLOCK,	10,		FILE_SIZE,	FAIL,		CLIENT,	},
+		{20,	CMD_UNLOCK,	10,		FILE_SIZE,	PASS,		SERVER,	},
 	/* Acquire whole file lock */
-		{21,	WRLOCK,	0,		0,		PASS,		SERVER,	},
-		{21,	WRLOCK,	0,		0,		FAIL,		CLIENT,	},
-		{21,	UNLOCK,	0,		0,		PASS,		SERVER,	},
+		{21,	CMD_WRLOCK,	0,		0,		PASS,		SERVER,	},
+		{21,	CMD_WRLOCK,	0,		0,		FAIL,		CLIENT,	},
+		{21,	CMD_UNLOCK,	0,		0,		PASS,		SERVER,	},
 	/* Acquire whole file lock, then range */
-		{22,	WRLOCK,	0,		0,		PASS,		SERVER,	},
-		{22,	WRLOCK,	1,		5,		FAIL,		CLIENT,	},
-		{22,	UNLOCK,	0,		0,		PASS,		SERVER,	},
+		{22,	CMD_WRLOCK,	0,		0,		PASS,		SERVER,	},
+		{22,	CMD_WRLOCK,	1,		5,		FAIL,		CLIENT,	},
+		{22,	CMD_UNLOCK,	0,		0,		PASS,		SERVER,	},
 	/* Acquire non-overlapping read locks */
-		{23,	RDLOCK, 1,		5,		PASS,		SERVER, },
-		{23,	RDLOCK, 7,		6,		PASS,		CLIENT, },
-		{23,	UNLOCK, 1, 		5,		PASS,		SERVER, },
-		{23,	UNLOCK, 7,		6,		PASS,		CLIENT, },
+		{23,	CMD_RDLOCK, 1,		5,		PASS,		SERVER, },
+		{23,	CMD_RDLOCK, 7,		6,		PASS,		CLIENT, },
+		{23,	CMD_UNLOCK, 1, 		5,		PASS,		SERVER, },
+		{23,	CMD_UNLOCK, 7,		6,		PASS,		CLIENT, },
 	/* Acquire overlapping read locks */
-		{24,	RDLOCK, 1,		5,		PASS,		SERVER, },
-		{24,	RDLOCK, 2,		6,		PASS,		CLIENT, },
-		{24,	UNLOCK, 1, 		5,		PASS,		SERVER, },
-		{24,	UNLOCK, 1,		7,		PASS,		CLIENT, },
+		{24,	CMD_RDLOCK, 1,		5,		PASS,		SERVER, },
+		{24,	CMD_RDLOCK, 2,		6,		PASS,		CLIENT, },
+		{24,	CMD_UNLOCK, 1, 		5,		PASS,		SERVER, },
+		{24,	CMD_UNLOCK, 1,		7,		PASS,		CLIENT, },
 	/* Acquire non-overlapping read and write locks */
-		{25,	RDLOCK, 1,		5,		PASS,		SERVER, },
-		{25,	WRLOCK, 7,		6,		PASS,		CLIENT, },
-		{25,	UNLOCK, 1, 		5,		PASS,		SERVER, },
-		{25,	UNLOCK, 7,		6,		PASS,		CLIENT, },
+		{25,	CMD_RDLOCK, 1,		5,		PASS,		SERVER, },
+		{25,	CMD_WRLOCK, 7,		6,		PASS,		CLIENT, },
+		{25,	CMD_UNLOCK, 1, 		5,		PASS,		SERVER, },
+		{25,	CMD_UNLOCK, 7,		6,		PASS,		CLIENT, },
 	/* Acquire overlapping read and write locks */
-		{26,	RDLOCK, 1,		5,		PASS,		SERVER, },
-		{26,	WRLOCK, 2,		6,		FAIL,		CLIENT, },
-		{26,	UNLOCK, 1, 		5,		PASS,		SERVER, },
+		{26,	CMD_RDLOCK, 1,		5,		PASS,		SERVER, },
+		{26,	CMD_WRLOCK, 2,		6,		FAIL,		CLIENT, },
+		{26,	CMD_UNLOCK, 1, 		5,		PASS,		SERVER, },
 	/* Acquire whole file lock, then close (without unlocking) */
-		{27,	WRLOCK,	0,		0,		PASS,		SERVER,	},
-		{27,	WRLOCK,	1,		5,		FAIL,		CLIENT,	},
-		{27,	F_CLOSE,0,		0,		PASS,		SERVER,	},
-		{27,	WRLOCK,	1,		5,		PASS,		CLIENT,	},
-		{27,	F_OPEN,	O_RDWR,		0,		PASS,		SERVER,	},
-		{27,	UNLOCK,	1,		5,		PASS,		CLIENT,	},
+		{27,	CMD_WRLOCK,	0,		0,		PASS,		SERVER,	},
+		{27,	CMD_WRLOCK,	1,		5,		FAIL,		CLIENT,	},
+		{27,	CMD_CLOSE,0,		0,		PASS,		SERVER,	},
+		{27,	CMD_WRLOCK,	1,		5,		PASS,		CLIENT,	},
+		{27,	CMD_OPEN,	O_RDWR,		0,		PASS,		SERVER,	},
+		{27,	CMD_UNLOCK,	1,		5,		PASS,		CLIENT,	},
 	/* Acquire two read locks, close one file and then reopen to check that first lock still exists */
-		{28,	RDLOCK,	1,		5,		PASS,		SERVER,	},
-		{28,	RDLOCK,	1,		5,		PASS,		CLIENT,	},
-		{28,	F_CLOSE,0,		0,		PASS,		SERVER,	},
-		{28,	F_OPEN,	O_RDWR,		0,		PASS,		SERVER,	},
-		{28,	WRLOCK,	0,		0,		FAIL,		SERVER,	},
-		{28,	UNLOCK,	1,		5,		PASS,		SERVER,	},
+		{28,	CMD_RDLOCK,	1,		5,		PASS,		SERVER,	},
+		{28,	CMD_RDLOCK,	1,		5,		PASS,		CLIENT,	},
+		{28,	CMD_CLOSE,0,		0,		PASS,		SERVER,	},
+		{28,	CMD_OPEN,	O_RDWR,		0,		PASS,		SERVER,	},
+		{28,	CMD_WRLOCK,	0,		0,		FAIL,		SERVER,	},
+		{28,	CMD_UNLOCK,	1,		5,		PASS,		SERVER,	},
 	/* Verify that F_GETLK for F_WRLCK doesn't require that file be opened for write */
-		{29,	F_CLOSE, 0,		0,		PASS,		SERVER, },
-		{29,	F_OPEN, O_RDONLY,	0,		PASS,		SERVER, },
-		{29,	WRTEST, 0,		0,		PASS,		SERVER, },
-		{29,	F_CLOSE,0,		0,		PASS,		SERVER,	},
-		{29,	F_OPEN,	O_RDWR,		0,		PASS,		SERVER,	},
+		{29,	CMD_CLOSE, 0,		0,		PASS,		SERVER, },
+		{29,	CMD_OPEN, O_RDONLY,	0,		PASS,		SERVER, },
+		{29,	CMD_WRTEST, 0,		0,		PASS,		SERVER, },
+		{29,	CMD_CLOSE,0,		0,		PASS,		SERVER,	},
+		{29,	CMD_OPEN,	O_RDWR,		0,		PASS,		SERVER,	},
 #ifdef macosx
 	/* Close the opened file and open the file with SHLOCK, other client will try to open with SHLOCK too */
-		{30,	F_CLOSE,0,		0,		PASS,		SERVER,	},
-		{30,	F_OPEN,	O_RDWR|O_SHLOCK|O_NONBLOCK,	0,	PASS,		SERVER,	},
-		{30,	F_CLOSE,0,		0,		PASS,		CLIENT,	},
-		{30,	F_OPEN,	O_RDWR|O_SHLOCK|O_NONBLOCK,	0,	PASS,		CLIENT,	},
+		{30,	CMD_CLOSE,0,		0,		PASS,		SERVER,	},
+		{30,	CMD_OPEN,	O_RDWR|O_SHLOCK|O_NONBLOCK,	0,	PASS,		SERVER,	},
+		{30,	CMD_CLOSE,0,		0,		PASS,		CLIENT,	},
+		{30,	CMD_OPEN,	O_RDWR|O_SHLOCK|O_NONBLOCK,	0,	PASS,		CLIENT,	},
 	/* Close the opened file and open the file with SHLOCK, other client will try to open with EXLOCK */
-		{31,	F_CLOSE,0,		0,		PASS,		SERVER,	},
-		{31,	F_CLOSE,0,		0,		PASS,		CLIENT,	},
-		{31,	F_OPEN,	O_RDWR|O_SHLOCK|O_NONBLOCK,	0,	PASS,		SERVER,	},
-		{31,	F_OPEN,	O_RDWR|O_EXLOCK|O_NONBLOCK,	0,	FAIL,		CLIENT,	},
+		{31,	CMD_CLOSE,0,		0,		PASS,		SERVER,	},
+		{31,	CMD_CLOSE,0,		0,		PASS,		CLIENT,	},
+		{31,	CMD_OPEN,	O_RDWR|O_SHLOCK|O_NONBLOCK,	0,	PASS,		SERVER,	},
+		{31,	CMD_OPEN,	O_RDWR|O_EXLOCK|O_NONBLOCK,	0,	FAIL,		CLIENT,	},
 	/* Close the opened file and open the file with EXLOCK, other client will try to open with EXLOCK too */
-		{32,	F_CLOSE,0,		0,		PASS,		SERVER,	},
-		{32,	F_CLOSE,0,		0,		FAIL,		CLIENT,	},
-		{32,	F_OPEN,	O_RDWR|O_EXLOCK|O_NONBLOCK,	0,	PASS,		SERVER,	},
-		{32,	F_OPEN,	O_RDWR|O_EXLOCK|O_NONBLOCK,	0,	FAIL,		CLIENT,	},
-		{32,	F_CLOSE,0,		0,		PASS,		SERVER,	},
-		{32,	F_CLOSE,0,		0,		FAIL,		CLIENT,	},
-		{32,	F_OPEN,	O_RDWR,		0,		PASS,		SERVER,	},
-		{32,	F_OPEN,	O_RDWR,		0,		PASS,		CLIENT,	},
+		{32,	CMD_CLOSE,0,		0,		PASS,		SERVER,	},
+		{32,	CMD_CLOSE,0,		0,		FAIL,		CLIENT,	},
+		{32,	CMD_OPEN,	O_RDWR|O_EXLOCK|O_NONBLOCK,	0,	PASS,		SERVER,	},
+		{32,	CMD_OPEN,	O_RDWR|O_EXLOCK|O_NONBLOCK,	0,	FAIL,		CLIENT,	},
+		{32,	CMD_CLOSE,0,		0,		PASS,		SERVER,	},
+		{32,	CMD_CLOSE,0,		0,		FAIL,		CLIENT,	},
+		{32,	CMD_OPEN,	O_RDWR,		0,		PASS,		SERVER,	},
+		{32,	CMD_OPEN,	O_RDWR,		0,		PASS,		CLIENT,	},
 #endif /* macosx */
 	/* indicate end of array */
 		{0,0,0,0,0,SERVER},
@@ -962,25 +962,25 @@ main(int argc, char *argv[])
 
 		if(tests[index][TEST_NUM] != 0) {
 		    switch(tests[index][COMMAND]) {
-			case WRLOCK:
+			case CMD_WRLOCK:
 			    result = do_lock(F_SETLK, F_WRLCK, tests[index][OFFSET], tests[index][LENGTH]);
 			    break;
-			case RDLOCK:
+			case CMD_RDLOCK:
 			    result = do_lock(F_SETLK, F_RDLCK, tests[index][OFFSET], tests[index][LENGTH]);
 			    break;
-			case UNLOCK:
+			case CMD_UNLOCK:
 			    result = do_lock(F_SETLK, F_UNLCK, tests[index][OFFSET], tests[index][LENGTH]);
 			    break;
-			case F_CLOSE:
+			case CMD_CLOSE:
 			    result = do_close();
 			    break;
-			case F_OPEN:
+			case CMD_OPEN:
 			    result = do_open(tests[index][FLAGS]);
 			    break;
-			case WRTEST:
+			case CMD_WRTEST:
 			    result = do_lock(F_GETLK, F_WRLCK, tests[index][OFFSET], tests[index][LENGTH]);
 			    break;
-			case RDTEST:
+			case CMD_RDTEST:
 			    result = do_lock(F_GETLK, F_RDLCK, tests[index][OFFSET], tests[index][LENGTH]);
 			    break;
 		    }
@@ -989,10 +989,10 @@ main(int argc, char *argv[])
 			/* We have a failure */
 			if(debug)
 			    fprintf(stderr, "Server failure in test %d, while %sing using offset %lld, length %lld - err = %d:%s\n", 
-					ctl.test, tests[index][COMMAND]==WRLOCK?"write lock":
-						tests[index][COMMAND]==RDLOCK?"read lock":
-						tests[index][COMMAND]==UNLOCK?"unlock":
-						tests[index][COMMAND]==F_OPEN?"open":"clos", 
+					ctl.test, tests[index][COMMAND]==CMD_WRLOCK?"write lock":
+						tests[index][COMMAND]==CMD_RDLOCK?"read lock":
+						tests[index][COMMAND]==CMD_UNLOCK?"unlock":
+						tests[index][COMMAND]==CMD_OPEN?"open":"clos", 
 						(long long)tests[index][OFFSET],
 						(long long)tests[index][LENGTH],
 						saved_errno, strerror(saved_errno));
@@ -1009,10 +1009,10 @@ main(int argc, char *argv[])
 		} 
 		if(debug > 1)
 		    fprintf(stderr, "Sending command to client (%d) - %s - %lld:%lld\n", 
-					index, tests[index][COMMAND]==WRLOCK?"write lock":
-					tests[index][COMMAND]==RDLOCK?"read lock":
-					tests[index][COMMAND]==UNLOCK?"unlock": 
-					tests[index][COMMAND]==F_OPEN?"open":"clos", 
+					index, tests[index][COMMAND]==CMD_WRLOCK?"write lock":
+					tests[index][COMMAND]==CMD_RDLOCK?"read lock":
+					tests[index][COMMAND]==CMD_UNLOCK?"unlock": 
+					tests[index][COMMAND]==CMD_OPEN?"open":"clos", 
 					(long long)tests[index][OFFSET],
 					(long long)tests[index][LENGTH]);
 		/* get the client to do something */
@@ -1027,10 +1027,10 @@ main(int argc, char *argv[])
 			fail_flag++;
 			if(debug)
 			    fprintf(stderr, "Client failure in test %d, while %sing using offset %lld, length %lld - err = %d:%s\n",
-					ctl.test, ctl.command==WRLOCK?"write lock":
-					ctl.command==RDLOCK?"read lock":
-					ctl.command==UNLOCK?"unlock":
-					ctl.command==F_OPEN?"open":"clos",
+					ctl.test, ctl.command==CMD_WRLOCK?"write lock":
+					ctl.command==CMD_RDLOCK?"read lock":
+					ctl.command==CMD_UNLOCK?"unlock":
+					ctl.command==CMD_OPEN?"open":"clos",
 					(long long)ctl.offset, (long long)ctl.length,
 					ctl.error, strerror(ctl.error));
 			fprintf(stderr, "Client failure in %lld:%s\n",
@@ -1074,25 +1074,25 @@ main(int argc, char *argv[])
 	    ctl.offset = tests[index][OFFSET];
 	    ctl.length = tests[index][LENGTH];
 	    switch(tests[index][COMMAND]) {
-		case WRLOCK:
+		case CMD_WRLOCK:
 		    result = do_lock(F_SETLK, F_WRLCK, tests[index][OFFSET], tests[index][LENGTH]);
 		    break;
-		case RDLOCK:
+		case CMD_RDLOCK:
 		    result = do_lock(F_SETLK, F_RDLCK, tests[index][OFFSET], tests[index][LENGTH]);
 		    break;
-		case UNLOCK:
+		case CMD_UNLOCK:
 		    result = do_lock(F_SETLK, F_UNLCK, tests[index][OFFSET], tests[index][LENGTH]);
 		    break;
-		case F_CLOSE:
+		case CMD_CLOSE:
 		    result = do_close();
 		    break;
-		case F_OPEN:
+		case CMD_OPEN:
 		    result = do_open(tests[index][FLAGS]);
 		    break;
-		case WRTEST:
+		case CMD_WRTEST:
 		    result = do_lock(F_GETLK, F_WRLCK, tests[index][OFFSET], tests[index][LENGTH]);
 		    break;
-		case RDTEST:
+		case CMD_RDTEST:
 		    result = do_lock(F_GETLK, F_RDLCK, tests[index][OFFSET], tests[index][LENGTH]);
 		    break;
 	    }
-- 
2.20.1
